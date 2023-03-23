from ..shogi.komamove import *
from ..shogi.board import *
from ..shogi.evaluate import *
import csv
import re
import copy
import time
import numpy as np
from multiprocessing import Pool

    
f = open("kifu.csv", "r")
#f = open("kifumeizinsen.csv", "r")
rd = csv.reader(f)

Param = []
Param = np.loadtxt("Para_ver15_30000.csv",delimiter=',')
#Param = np.loadtxt("parameta.csv",delimiter=',')

def main ():
    train_count = 0
    C_LIST = []
    for i in range(70):
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
      
        for te_pro in kifu:
            setparameta(Param)
            if len(te_pro) == 7:    #len(+3334FU)==7 正しい形の手を実行する
                #print(te_pro)
                TE(te_pro,test_board,test_handS,test_handG)
                proEval = Evaluate(te_pro[0],test_board,test_handS,test_handG)
                
                test_board = copy.deepcopy(Board)
                test_handS = copy.deepcopy(HandS)
                test_handG = copy.deepcopy(HandG)
                
                te_all =  s_move(te_pro[0],test_board)+s_put(te_pro[0],test_board,test_handS,test_handG)

                ls = []
                
                for te in te_all:
                    a = make_ls(te,te_pro,proEval,Board,HandS,HandG)
                    if a == 1:
                        ls.append(1)
                    
                c = 0
                c += len(ls)
                c_list.append(c)
                
                TE(te_pro,Board,HandS,HandG)
                TE(te_pro,test_board,test_handS,test_handG)
         
        C_LIST += c_list
        print("平均",sum(c_list)/len(c_list))
        print("一致率",c_list.count(0)/len(c_list))
     
    print("全体平均",sum(C_LIST)/len(C_LIST))
    print("全体一致率",C_LIST.count(0)/len(C_LIST))
 
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
        ev = Evaluate(te[0],board,hands,handg)
         
        if ev >= proEval:
            return 1
        else:
            return 0
    
main()
f.close()



