from ..shogi.board import *
from ..shogi.evaluate import *
from ..shogi.komamove import *
import csv
import re
import copy
import time
import numpy as np
from multiprocessing import Pool

    
f = open("KIFUdata.csv", "r")
rd = csv.reader(f)

Param = []
Param = np.loadtxt("Para.csv",delimiter=',')

def Update_file():
    readFile = open("Para.csv", 'r')
    reader = csv.reader(readFile)
    lines = list(reader)
    lines[0] = Param
    writeFile = open("Para.csv", 'w')
    writer = csv.writer(writeFile)
    writer.writerows(lines)
    readFile.close()
    writeFile.close()


def main ():
    train_count = 0
    for i in range(10000):
        if i < 0:
            continue
            
        c_list = []
        Board = copy.deepcopy(BOARD)
        HandS = copy.deepcopy(HANDS)
        HandG = copy.deepcopy(HANDG)
        test_board = copy.deepcopy(BOARD)
        test_handS = copy.deepcopy(HANDS)
        test_handG = copy.deepcopy(HANDG)
        
        a = f.readline()
        kifu = re.split(r'[,"\n]', a)
        print(i ,"\n")
        t1 = time.time()

        for te_pro in kifu:
            setparameta(Param)
            if len(te_pro) == 7:    #len(+3334FU)==7 正しい形の手を実行する
                #print(te_pro)
                TE(te_pro,test_board,test_handS,test_handG)
                proEval , prote_Charac = evaluate(te_pro[0],test_board,test_handS,test_handG)
                
                test_board = copy.deepcopy(Board)
                test_handS = copy.deepcopy(HandS)
                test_handG = copy.deepcopy(HandG)
                
                te_all =  s_move(te_pro[0],test_board)+s_put(te_pro[0],test_board,test_handS,test_handG)

                ls = []
                
                for te in te_all:
                    cha = make_ls(te,te_pro,proEval,Board,HandS,HandG)
                    if cha != 0:
                        ls.append(cha)
                    
                Update_parameta(prote_Charac,ls,c_list)
                                       
                TE(te_pro,Board,HandS,HandG)
                TE(te_pro,test_board,test_handS,test_handG)
                
        #seisoku()
        print(c_list)
        t2 = time.time()
        print(t2-t1)
        
        train_count += 1
        if train_count == 100:
            train_count = 0
            Update_file()
 
def make_ls (te,te_pro,proEval,Board,HandS,HandG):
    board = copy.deepcopy(Board)
    hands = copy.deepcopy(HandS)
    handg = copy.deepcopy(HandG)
    
    if te == te_pro:
         return 0
    elif te_pro[5] == "O" and ((te_pro[0] == "+" and te_pro[4] == "4") or (te_pro[0] == "-" and te_pro[4] == "6")):
         return 0
    else:
        TE(te,board,hands,handg)
        ev, te_Charac = evaluate(te[0],board,hands,handg)
         
        if ev >= proEval:
            return te_Charac
        else:
            return 0
    
def Update_parameta(prote_Charac,Charac_list,c_list):
    global Param
    
    grade = np.zeros(51963119, dtype = int)
    c = 0
    for Charac in Charac_list:
        c += 1
        grade[prote_Charac] += 1
        grade[Charac] -= 1
    
    c_list.append(c)
    if c == 0:
        pass
    else:
        grade = 0.1*(1/c) * grade
        Param += grade
        
#def seisoku():
#    global Param
#    Param -= Param * np.abs(Param) * 0.00005
    
# (1 0.0001) (0.5 0.00005) (0.3 0.00003) (0.1 0)
    
main()
Update_file()
f.close()


