import numpy as np

PARAM = []

KOMA_VALUE = dict(OU=100000, RY=1100, UM=1000, HI=800, KA=700, KI=500, NG=480, NK=470, NY=450, TO=490, GI=400, KE=250, KY=230, FU=80, HI1=850, HI2=1650, KA1=750, KA2=1450, KI1=550, KI2=1100, KI3=1600, KI4=2075, GI1=430, GI2=860, GI3=1260, GI4=1630, KE1=300, KE2=575, KE3=825, KE4=1025, KY1=250, KY2=500, KY3=730, KY4=930, FU1=110, FU2=220, FU3=310, FU4=390, FU5=460, FU6=520)


def setparameta(param):
    global PARAM
    PARAM = param
    
    
def sum_koma_value(s, board, hands, handg):
    sum = 0
    for y in [1,2,3,4,5,6,7,8,9]:
        for x in [1,2,3,4,5,6,7,8,9]:
            if board[y][x] != 0 and board[y][x][0] == s:
                K = board[y][x]
                sum += KOMA_VALUE[K[1]+K[2]]
            elif board[y][x] != 0 and board[y][x][0] != s:
                K = board[y][x]
                sum -= KOMA_VALUE[K[1]+K[2]]
                
    for k in ["HI","KA","KI","GI","KE","KY","FU"]:
        if hands[k] != 0:
            if (k == "FU") and (hands["FU"] >= 6):
                if s == "+":
                    sum += KOMA_VALUE["FU6"]
                elif s == "-":
                    sum -= KOMA_VALUE["FU6"]
            else:
                if s == "+":
                    sum += KOMA_VALUE[k+str(hands[k])]
                elif s == "-":
                    sum -= KOMA_VALUE[k+str(hands[k])]
    
    for k in ["HI","KA","KI","GI","KE","KY","FU"]:
        if handg[k] != 0:
            if (k == "FU") and (handg["FU"] >= 6):
                if s == "+":
                    sum -= KOMA_VALUE["FU6"]
                elif s == "-":
                    sum += KOMA_VALUE["FU6"]
            else:
                if s == "+":
                    sum -= KOMA_VALUE[k+str(handg[k])]
                elif s == "-":
                    sum += KOMA_VALUE[k+str(handg[k])]
    
    return sum


def make_komaposi(board):
    OUs = []
    OUg = []
    HIs = []
    HIg = []
    KAs = []
    KAg = []
    KIs = []
    KIg = []
    GIs = []
    GIg = []
    KEs = []
    KEg = []
    KYs = []
    KYg = []
    FUs = []
    FUg = []
    RYs = []
    RYg = []
    UMs = []
    UMg = []
    
    sKdic = dict(OU=OUs, HI=HIs, KA=KAs, KI=KIs, GI=GIs, KE=KEs, KY=KYs, FU=FUs, RY=RYs,             UM=UMs, NG=KIs, NK=KIs, NY=KIs, TO=KIs)
    
    gKdic = dict(OU=OUg, HI=HIg, KA=KAg, KI=KIg, GI=GIg, KE=KEg, KY=KYg, FU=FUg, RY=RYg,             UM=UMg, NG=KIs, NK=KIg, NY=KIg, TO=KIg)
    
    for x in [1,2,3,4,5,6,7,8,9]:
        for y in [1,2,3,4,5,6,7,8,9]:
            if board[y][x] != 0:
                if board[y][x][0]=="+":
                    sKdic[board[y][x][1]+board[y][x][2]].append([x,y])
                else:
                    gKdic[board[y][x][1]+board[y][x][2]].append([x,y])
                
    return [OUs,OUg],[HIs,KAs,KIs,GIs,KEs,KYs,FUs,RYs,UMs,HIg,KAg,KIg,GIg,KEg,KYg,FUg,RYg,UMg]
            
def posi_to_onedim (s, x, y):
    if s == "+":
        return (10-x) + 9*(9-y)
    elif s == "-":
        return x + 9*(y-1)
    
def make_charac(s, board):
    OUposi,Kposi = make_komaposi(board)
    sCharac = []
    gCharac = []
    
    if OUposi[0] == [] or OUposi[1] == []:
        return []
        
    else:
        OUs = OUposi[0][0]
        OUg = OUposi[1][0]
    
        OUsn = posi_to_onedim ("+", OUs[0], OUs[1])
        OUgn = posi_to_onedim ("-", OUg[0], OUg[1])
        
    if OUsn > 45 or OUgn > 45:
        return []
         
    if s == "+":
        for i in range(9):
            for posi in Kposi[i]:
                if posi == []:
                    break
                Ksn = posi_to_onedim("+", posi[0], posi[1])
                sCharac.append((OUsn-1)*32805 + (OUgn-1)*729 + (i-1)*81 + Ksn - 1)
                
        for i in range(18):
            for Posi in Kposi[i]:
                if Posi == []:
                    break
                Ksn = posi_to_onedim("+", Posi[0], Posi[1])
            
                for j in range(18):
                    for posi in Kposi[j]:
                        if posi == []:
                            break
                        elif j < i:
                            pass
                        else:
                            ksn = posi_to_onedim("-", posi[0], posi[1])
                            sCharac.append(int(1476224 + ((OUsn-1)*1121931) + 6561*0.5*i*(37-i) + (Ksn-1)*81*(18-i) + (j-i)*81 + ksn))
                            
        return sCharac
      
    elif s == "-":
        for i in [9,10,11,12,13,14,15,16,17]:
            for posi in Kposi[i]:
                if posi == []:
                    break
                Kgn = posi_to_onedim("-", posi[0], posi[1])
                gCharac.append((OUgn-1)*32805 + (OUsn-1)*729 + (i-1)*81 + Kgn - 1)
        for i,I in zip(range(18),[9,10,11,12,13,14,15,16,17,0,1,2,3,4,5,6,7,8]):
            for Posi in Kposi[I]:
                if Posi == []:
                    break
                Kgn = posi_to_onedim("-", Posi[0], Posi[1])
                for j,J in zip(range(18), [9,10,11,12,13,14,15,16,17,0,1,2,3,4,5,6,7,8]):
                    for posi in Kposi[J]:
                        if posi == []:
                            break
                        elif j < i:
                            pass
                        else:
                            kgn = posi_to_onedim("-", posi[0], posi[1])
                            gCharac.append(int(1476224 + ((OUgn-1)*1121931) + 6561*0.5*i*(37-i) + (Kgn-1)*81*(18-i) + (j-i)*81 + kgn))
        
        return gCharac
    
    
#trainで使う評価関数、評価値と盤面特徴を同時に返す。
def evaluate_train(s, board, hands, handg):
    ev1 = sum_koma_value(s, board, hands, handg)
    Chara = make_charac(s, board)
    ev2 = np.sum(PARAM[Chara])
    
    return ev1+ev2, Chara


#matchで使う評価関数、評価値のみ返す。
def evaluate (s,board,hands,handg):
    ev1 = sum_koma_value(s, board, hands, handg)
    Chara = make_charac(s, board)
    ev2 = np.sum(PARAM[Chara])
    
    return ev1+ev2


    
    




