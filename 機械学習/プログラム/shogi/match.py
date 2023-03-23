import copy
import csv
from tkinter import messagebox
from math import floor
from multiprocessing import Process
from multiprocessing import Manager, Value, Lock

import numpy as np

from .board import *
from .evaluate import *
from .komamove import *


Board = [i[:] for i in BOARD]
HandS = HANDS.copy()
HandG = HANDG.copy()

AIS = ""
PS = ""


def match_init():
    global AIS, PS
    param = np.loadtxt("Para_ver15.csv",delimiter=',')
    setparameta(param)
    res = messagebox.askyesno("","先手ですか？")
    if res == True:
        AIS = "-"
        PS = "+"
    else:
        AIS = "+"
        PS = "-"


def sort_te(s, te_list, board, hands, handg, depth):
    dic = dict()
    evlist = []
    sort = []

    for te in te_list:
        Board0 = [i[:] for i in board]
        HandS0 = hands.copy()
        HandG0 = handg.copy()
        TE (te, Board0, HandS0, HandG0)
        eval = evaluate(s, Board0, HandS0, HandG0)
        dic[str(eval)] = te
   
    evlist = sorted(map(float ,dic.keys()) , reverse = True)
    all = len(evlist)

    if depth == 1:
        limit = 60
    elif depth == 2:
        limit = 40
    elif depth == 3:
        limit = 30
    
    else:
        limit = 100
        
        count = 0
        c = 0
        
        for ev in evlist:
            count += 1
            c += 1
            if count > limit:
                break
            elif c == depth / 10:
                sort.append(dic[str(ev)])
            if c == 5:
                c = 0
        
        return sort
        
    count = 0
    for ev in evlist:
        count += 1
        if count >= limit:
            break
        else:
            sort.append(dic[str(ev)])
        
    return sort



def depth7(mp,board,hands,handg,min):
    max = -100000000
    for te in mp:
        Board7 = [i[:] for i in board]
        HandS7 = hands.copy()
        HandG7 = handg.copy()
        TE (te, Board7, HandS7, HandG7)
        eval = evaluate(AIS, Board7, HandS7, HandG7)
        
        if min <= eval:
            return 100000001  #βカット
        elif max < eval:
            max = eval
            
    return max
     
     
def depth6(mp, board, hands, handg, max):
    min = 100000000
    for te in mp:
        Board6 = [i[:] for i in board]
        HandS6 = hands.copy()
        HandG6 = handg.copy()
        TE (te, Board6, HandS6, HandG6)
        AI_mp = s_move(AIS, Board6)
        eval = depth7(AI_mp,Board6, HandS6, HandG6, min)
        #eval = evaluate(AIS, Board4, HandS4, HandG4)
        if max >= eval:
            return -100000001  #αカット
        elif min > eval:
            min = eval
            
    return min

def depth5(mp,board,hands,handg,min):
    max = -100000000
    for te in mp:
        Board5 = [i[:] for i in board]
        HandS5 = hands.copy()
        HandG5 = handg.copy()
        TE (te, Board5, HandS5, HandG5)
        
        eval = evaluate(AIS, Board5, HandS5, HandG5)
        
        if min <= eval:
            return 100000001  #βカット
        elif max < eval:
            max = eval
            
    return max
     
     
def depth4(mp, board, hands, handg, max):
    min = 100000000
    for te in mp:
        Board4 = [i[:] for i in board]
        HandS4 = hands.copy()
        HandG4 = handg.copy()
        TE (te, Board4, HandS4, HandG4)
        AI_mp = s_move(AIS, Board4)
        
        eval = depth5(AI_mp,Board4, HandS4, HandG4, min)
        
        if max >= eval:
            return -100000001  #αカット
        elif min > eval:
            min = eval
            
    return min
    
    
def depth3(mp, board, hands, handg, min):
    max = -100000000
    for te in mp:
        Board3 = [i[:] for i in board]
        HandS3 = hands.copy()
        HandG3 = handg.copy()
        TE (te, Board3, HandS3, HandG3)
        p_mp = s_move(PS, Board3)+s_put(PS, Board3, HandS3, HandG3)
        P_mp = sort_te(PS, p_mp, Board3, HandS3, HandG3, 3)
        
        eval = depth4(P_mp, Board3, HandS3, HandG3, max)
            
        if min <= eval:
            return 100000001  #βカット
        elif max < eval:
            max = eval
        
    return max
        
def depth2(mp,board,hands,handg,max):
    min = 100000000
    for te in mp:
        Board2 = [i[:] for i in board]
        HandS2 = hands.copy()
        HandG2 = handg.copy()
        TE (te, Board2, HandS2, HandG2)
        ai_mp = s_move(AIS, Board2)#+s_put(AIS, Board2, HandS2, HandG2)
        AI_mp = sort_te(AIS, ai_mp, Board2, HandS2, HandG2, 2)

        eval = depth3(AI_mp, Board2, HandS2, HandG2, min)
        if max >= eval:
            return -100000001  #αカット
        elif min > eval:
            min = eval
        
    return min
    
def depth1(mp,l,max,lock):

    ply = 1  #ほんとは　1
    for k in ["HI","KA","KI","GI","KE","KY","FU"]:
        if not (HandS[k] == 0 and HandG[k] == 0):
            ply = 5
    if mp == []:
        return 0
    for te in mp:
        print(te)
        Board1 = [i[:] for i in Board]
        HandS1 = HandS.copy()
        HandG1 = HandG.copy()
        TE (te, Board1, HandS1, HandG1)
        if ply == 1:
            eval = evaluate(AIS, Board1, HandS1, HandG1)
        else:
            p_mp = s_move(PS, Board1) + s_put(PS, Board1, HandS1, HandG1)
            P_mp = sort_te(PS, p_mp, Board1, HandS1, HandG1, 1)
            eval = depth2 (P_mp, Board1, HandS1, HandG1, max.value)
        
        if max.value < eval:
            lock.acquire()
            max.value = eval
            l.append([te, eval])
            lock.release()
  
def ou_posi(s, board):
    if s == "+":
        for y in [9,8,7,6,5,4,3,2,1]:
            for x in [1,2,3,4,5,6,7,8,9]:
                if board[y][x] == "+OU":
                    return x,y
    elif s == "-":
        for y in [1,2,3,4,5,6,7,8,9]:
            for x in [1,2,3,4,5,6,7,8,9]:
                if board[y][x] == "-OU":
                    return x,y
                                    
def oute_judge (s, board):
    ls = s_move(s, board)
    ox, oy = ou_posi(ss(s), board)
    for i in ls:
        if ox == int(i[3]) and oy == int(i[4]):
            return 1
    return 0


def escapeoute (s,board,hands,handg):
    mp = s_move(s,board) + s_put(s,board,hands,handg)
    LS = []
    for te in mp:
        B = [i[:] for i in board]
        HS = hands.copy()
        HG = handg.copy()
        TE (te, B, HS, HG)
        a = oute_judge (ss(s),B)
        if a == 1:
            pass
        else:
            LS.append(te)
 
    return LS
    
    
def oute(s, board, hands, handg):
    mp = s_move(s, board) + s_put(s, board, hands, handg)
    LS = []
    for te in mp:
        B = [i[:] for i in board]
        HS = hands.copy()
        HG = handg.copy()
        TE (te, B, HS, HG)
        a = oute_judge (s, B)
        if a == 1:
            LS.append(te)
        else: pass
        
    return LS
    
    
def tumi_1te(s, B0, HS0, HG0):
    OUte = oute(s, B0, HS0, HG0)
    for te in OUte:
        B = [i[:] for i in B0]
        HS = HS0.copy()
        HG = HG0.copy()
        TE(te, B, HS, HG)
        if escapeoute(ss(s), B, HS, HG) == []:
            return 1
        
    return 0


def tumi(s, board, hands, handg):
    OUte1 = oute(s, board, hands, handg)
    for te1 in OUte1:
        B1 = [i[:] for i in board]
        HS1 = hands.copy()
        HG1 = handg.copy()
        TE (te1, B1, HS1, HG1)
        escOUte2 = escapeoute(ss(s), B1, HS1, HG1)
        if escOUte2 == []:
            return te1
        a = len(escOUte2)
        b = 0
        for te2 in escOUte2:
            B2 = [i[:] for i in B1]
            HS2 = HS1.copy()
            HG2 = HG1.copy()
            TE (te2, B2, HS2, HG2)
            b += 1
            if tumi_1te(s,B2,HS2,HG2) == 0:
                break
            elif b == a:
                return te1

    return 0

    
def aite():
    if oute_judge(PS,Board):
        AI_mp = escapeoute(AIS,Board,HandS,HandG)
        m = Manager()
        lock = Lock()
        l = m.list()
        max = Value('d', -100000000.0)
        process1 = Process(target=depth1, args=(AI_mp,l,max,lock))
        process1.start()
        process1.join()
        print(l)
        return l[len(l)-1][0]
        
    tumu_te = tumi(AIS,Board,HandS,HandG)
    
    if tumu_te != 0:
        return tumu_te
    
    else:
        ai_mp = s_move(AIS, Board)+s_put(AIS, Board, HandS, HandG)
        AI_mp1 = sort_te(AIS, ai_mp, Board, HandS, HandG, 10)
        AI_mp2 = sort_te(AIS, ai_mp, Board, HandS, HandG, 20)
        AI_mp3 = sort_te(AIS, ai_mp, Board, HandS, HandG, 30)
        AI_mp4 = sort_te(AIS, ai_mp, Board, HandS, HandG, 40)
        AI_mp5 = sort_te(AIS, ai_mp, Board, HandS, HandG, 50)
  
        m = Manager()
        lock = Lock()
        l = m.list()
       
        max = Value('d', -100000000.0)
            
        process1 = Process(target=depth1, args=(AI_mp1,l,max,lock))
        process1.start()
        process2 = Process(target=depth1, args=(AI_mp2,l,max,lock))
        process2.start()
        process3 = Process(target=depth1, args=(AI_mp3,l,max,lock))
        process3.start()
        process4 = Process(target=depth1, args=(AI_mp4,l,max,lock))
        process4.start()
        process5 = Process(target=depth1, args=(AI_mp5,l,max,lock))
        process5.start()
            
        process1.join()
        process2.join()
        process3.join()
        process4.join()
        process5.join()
            
        print(l)

        return l[len(l)-1][0]
        
   
def pte_aux(te, k):
    dic = dict(OU="OU",HI="RY",KA="UM",KI="KI",GI="NG",KE="NK",KY="NY",FU="TO",
    RY="RY",UM="UM",NG="NG",NK="NK",NY="NY",TO="TO")
    te_aux = te[0]+te[1]+te[2]+te[3]+te[4]+dic[k]
    
    return te, te_aux
    
    
def pte(s, te):
    te1, te2 = pte_aux(te, te[5]+te[6])
    P_mp = s_move(s, Board) + s_put(s, Board, HandS, HandG)
    if te1 == te2:
        if te1 in P_mp:
            TE(te, Board, HandS, HandG)
            return 1
        else:
            return 0
    else:
        q1 = te1 in P_mp
        q2 = te2 in P_mp
        if q1 and q2:
            res = messagebox.askyesno("","成りますか？")
            if res == True:
                TE(te2, Board, HandS, HandG)
                return 1
            else:
                TE(te1, Board, HandS, HandG)
                return 1
        elif q1:
                TE(te1, Board, HandS, HandG)
                return 1
        elif q2:
                TE(te2, Board, HandS, HandG)
                return 1
        else:
            return 0
  
def ss (s):
    if s == "-":
        return "+"
    else:
        return "-"
            