import copy

BOARD = [
[0],
[0,"-KY","-KE","-GI","-KI","-OU","-KI","-GI","-KE","-KY"],
[0,0,"-KA",0,0,0,0,0,"-HI",0],
[0,"-FU","-FU","-FU","-FU","-FU","-FU","-FU","-FU","-FU"],
[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,0],
[0,"+FU","+FU","+FU","+FU","+FU","+FU","+FU","+FU","+FU"],
[0,0,"+HI",0,0,0,0,0,"+KA",0],
[0,"+KY","+KE","+GI","+KI","+OU","+KI","+GI","+KE","+KY"]
]

HANDS = dict(HI=0, KA=0, KI=0, GI=0, KE=0, KY=0, FU=0, OU=0)
HANDG = dict(HI=0, KA=0, KI=0, GI=0, KE=0, KY=0, FU=0, OU=0)


def nari_to_normal(nk):
    if nk == "TO":
        return "FU"
    elif nk == "NG":
        return "GI"
    elif nk == "NK":
        return "KE"
    elif nk == "NY":
        return "KY"
    elif nk == "RY":
        return "HI"
    elif nk == "UM":
        return "KA"
    else:
        return nk
        
        
def TE(te,board,hands,handg):
    s = te[0]
    ox = int(te[1])
    oy = int(te[2])
    x = int(te[3])
    y = int(te[4])
    k = te[5]+te[6]
    
    if s == "+":
        if ox == 0:
            hands[k] -= 1
        elif board[y][x] == 0:
            board[oy][ox] = 0
        else:
            board[oy][ox] = 0
            K = board[y][x]
            hands[nari_to_normal(K[1]+K[2])] += 1
        
    elif s == "-":
        if ox == 0:
            handg[k] -= 1
        elif board[y][x] == 0:
            board[oy][ox] = 0
        else:
            board[oy][ox] = 0
            K = board[y][x]
            handg[nari_to_normal(K[1]+K[2])] += 1
            
    board[y][x] = s+k

 

