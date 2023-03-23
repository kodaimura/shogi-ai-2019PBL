#引数　s:+ or - / x,y:int型

def ou(s, x, y):
    return [s + str(x) + str(y) + str(x-1) + str(y-1) + "OU",
            s + str(x) + str(y) + str(x) + str(y-1) + "OU",
            s + str(x) + str(y) + str(x+1) + str(y-1) + "OU",
            s + str(x) + str(y) + str(x-1) + str(y) + "OU",
            s + str(x) + str(y) + str(x+1) + str(y) + "OU",
            s + str(x) + str(y) + str(x-1) + str(y+1) + "OU",
            s + str(x) + str(y) + str(x) + str(y+1) + "OU",
            s + str(x) + str(y) + str(x+1) + str(y+1) + "OU"]


#引数　k: KI NG NE NY TO のいずれか
def ki(s, x, y, k):
    if s == "+":
        return [s + str(x) + str(y) + str(x-1) + str(y-1) + k,
                s + str(x) + str(y) + str(x) + str(y-1) + k,
                s + str(x) + str(y) + str(x+1) + str(y-1) + k,
                s + str(x) + str(y) + str(x-1) + str(y) + k,
                s + str(x) + str(y) + str(x+1) + str(y) + k,
                s + str(x) + str(y) + str(x) + str(y+1) + k]
    else:
        return [s + str(x) + str(y) + str(x-1) + str(y+1) + k,
                s + str(x) + str(y) + str(x) + str(y+1) + k,
                s + str(x) + str(y) + str(x+1) + str(y+1) + k,
                s + str(x) + str(y) + str(x-1) + str(y) + k,
                s + str(x) + str(y) + str(x+1) + str(y) + k,
                s + str(x) + str(y) + str(x) + str(y-1) + k]
            
            
def gi(s, x, y):
    if s == "+":
        if 4 < y:
            return [s + str(x) + str(y) + str(x-1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x-1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y+1) + "GI"]
            
        elif y == 4:
            return [s + str(x) + str(y) + str(x-1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x-1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x-1) + str(y-1) + "NG",
                    s + str(x) + str(y) + str(x) + str(y-1) + "NG",
                    s + str(x) + str(y) + str(x+1) + str(y-1) + "NG"]
        else:
            return [s + str(x) + str(y) + str(x-1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x) + str(y-1)+ "GI",
                    s + str(x) + str(y) + str(x+1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x-1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x-1) + str(y-1) + "NG",
                    s + str(x) + str(y) + str(x) + str(y-1) + "NG",
                    s + str(x) + str(y) + str(x+1) + str(y-1) + "NG",
                    s + str(x) + str(y) + str(x-1) + str(y+1) + "NG",
                    s + str(x) + str(y) + str(x+1) + str(y+1) + "NG",]
                    
    elif s == "-":
        if 6 > y:
            return [s + str(x) + str(y) + str(x-1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x-1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y-1) + "GI"]
            
        elif y == 6:
            return [s + str(x) + str(y) + str(x-1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x-1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x-1) + str(y+1) + "NG",
                    s + str(x) + str(y) + str(x) + str(y+1) + "NG",
                    s + str(x) + str(y) + str(x+1) + str(y+1) + "NG"]
        else:
            return [s + str(x) + str(y) + str(x-1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y+1) + "GI",
                    s + str(x) + str(y) + str(x-1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x+1) + str(y-1) + "GI",
                    s + str(x) + str(y) + str(x-1) + str(y+1) + "NG",
                    s + str(x) + str(y) + str(x) + str(y+1) + "NG",
                    s + str(x) + str(y) + str(x+1) + str(y+1) + "NG",
                    s + str(x) + str(y) + str(x-1) + str(y-1) + "NG",
                    s + str(x) + str(y) + str(x+1) + str(y-1) + "NG",]
        

def ke(s, x ,y):
    if s == "+":
        if y > 5:
            return [s + str(x) + str(y) + str(x-1) + str(y-2) + "KE",
                    s + str(x) + str(y) + str(x+1) + str(y-2) + "KE"]
        elif y == 5:
            return [s + str(x) + str(y) + str(x-1) + str(y-2) + "KE",
                    s + str(x) + str(y) + str(x+1) + str(y-2) + "KE",
                    s + str(x) + str(y) + str(x-1) + str(y-2) + "NK",
                    s + str(x) + str(y) + str(x+1) + str(y-2) + "NK"]
        else:
            return [s + str(x) + str(y) + str(x-1) + str(y-2) + "NK",
                    s + str(x) + str(y) + str(x+1) + str(y-2) + "NK"]
    elif s == "-":
        if y < 5:
            return [s + str(x) + str(y) + str(x-1) + str(y+2) + "KE",
                    s + str(x) + str(y) + str(x+1) + str(y+2) + "KE"]
        elif y == 5:
            return [s + str(x) + str(y) + str(x-1) + str(y+2) + "KE",
                    s + str(x) + str(y) + str(x+1) + str(y+2) + "KE",
                    s + str(x) + str(y) + str(x-1) + str(y+2) + "NK",
                    s + str(x) + str(y) + str(x+1) + str(y+2) + "NK"]
        else:
            return [s + str(x) + str(y) + str(x-1) + str(y+2) + "NK",
                    s + str(x) + str(y) + str(x+1) + str(y+2) + "NK"]
               
               
def fu(s, x, y):
    if s == "+":
        if y > 4:
            return [s + str(x) + str(y) + str(x) + str(y-1) + "FU"]
        else:
            return [s + str(x) + str(y) + str(x) + str(y-1) + "TO"]
            
    elif s == "-":
        if y < 6:
            return [s + str(x) + str(y) + str(x) + str(y+1) + "FU"]
        else:
            return [s + str(x) + str(y) + str(x) + str(y+1) + "TO"]
        
        
def ky(s, x, y, board):
    ls = []
    if s == "+":
        for i in [1,2,3,4,5,6,7,8]:
            if y-i == 1:
                ls.append(s + str(x) + str(y) + str(x) + str(y-i) + "NY")
                return ls
            elif y-i == 2:
                ls.append(s + str(x) + str(y) + str(x) + str(y-i) + "NY")
                if board[2][x] == 0:
                    pass
                else:
                    return ls
            elif y-i == 3:
                ls.append(s + str(x) + str(y) + str(x) + str(y-i) + "KY")
                ls.append(s + str(x) + str(y) + str(x) + str(y-i) + "NY")
                if board[3][x] == 0:
                    pass
                else:
                    return ls
            elif board[y-i][x] == 0:
                ls.append(s + str(x) + str(y) + str(x) + str(y-i) + "KY")
            else:
                ls.append(s + str(x) + str(y) + str(x) + str(y-i) + "KY")
                return ls
                
    elif s == "-":
           for i in [1,2,3,4,5,6,7,8]:
               if y+i == 9:
                   ls.append(s + str(x) + str(y) + str(x) + str(y+i) + "NY")
                   return ls
               elif y+i == 8:
                   ls.append(s + str(x) + str(y) + str(x) + str(y+i) + "NY")
                   if board[8][x] == 0:
                       pass
                   else:
                       return ls
               elif y+i == 7:
                   ls.append(s + str(x) + str(y) + str(x) + str(y+i) + "KY")
                   ls.append(s + str(x) + str(y) + str(x) + str(y+i) + "NY")
                   if board[7][x] == 0:
                       pass
                   else:
                       return ls
               elif board[y+i][x] == 0:
                   ls.append(s + str(x) + str(y) + str(x) + str(y+i) + "KY")
               else:
                   ls.append(s + str(x) + str(y) + str(x) + str(y+i) + "KY")
                   return ls
             
             
def hi(s, x, y, board):
    ls = []
    if (s == "+" and y < 4) or (s == "-" and y > 6):
        for i in [1,2,3,4,5,6,7,8,9]:
            if y-i == 0:
                break
            else:
                ls.append(s + str(x) + str(y) + str(x) + str(y-i) + "RY")
                if board[y-i][x] != 0:
                    break
        for i in [1,2,3,4,5,6,7,8,9]:
            if y+i == 10:
                break
            else:
                ls.append(s + str(x) + str(y) + str(x) + str(y+i) + "RY")
                if board[y+i][x] != 0:
                    break
        for i in [1,2,3,4,5,6,7,8,9]:
            if x-i == 0:
                break
            else:
                ls.append(s + str(x) + str(y) + str(x-i) + str(y) + "RY")
                if board[y][x-i] != 0:
                    break
        for i in [1,2,3,4,5,6,7,8,9]:
            if x+i == 10:
                return ls
            else:
                ls.append(s + str(x) + str(y) + str(x+i) + str(y) + "RY")
                if board[y][x+i] != 0:
                    return ls

    else:
        for i in [1,2,3,4,5,6,7,8,9]:
            if y-i == 0:
                break
            else:
                if y-i < 4 and s == "+":
                    ls.append(s + str(x) + str(y) + str(x) + str(y-i) + "RY")
                    if board[y-i][x] != 0:
                        break
                else:
                    ls.append(s + str(x) + str(y) + str(x) + str(y-i) + "HI")
                    if board[y-i][x] != 0:
                        break
                    
        for i in [1,2,3,4,5,6,7,8,9]:
            if y+i == 10:
                break
            else:
                if y+i > 6 and s == "-":
                    ls.append(s + str(x) + str(y) + str(x) + str(y+i) + "RY")
                    if board[y+i][x] != 0:
                        break
                else:
                    ls.append(s + str(x) + str(y) + str(x) + str(y+i) + "HI")
                    if board[y+i][x] != 0:
                        break
                    
        for i in [1,2,3,4,5,6,7,8,9]:
            if x-i == 0:
                break
            else:
                ls.append(s + str(x) + str(y) + str(x-i) + str(y) + "HI")
                if board[y][x-i] != 0:
                    break
        
        for i in [1,2,3,4,5,6,7,8,9]:
            if x+i == 10:
                return ls
            else:
                ls.append(s + str(x) + str(y) + str(x+i) + str(y) + "HI")
                if board[y][x+i] != 0:
                    return ls
                 
                 
def boardout(x, y):
    if x == 0 or x == 10 or y == 0 or y == 10:
        return True
    else:
        return False
    
    
def ka(s, x, y, board):
    ls = []
    if (s == "+" and y < 4) or (s == "-" and y > 6):
        for i in [1,2,3,4,5,6,7,8,9]:
            if boardout(x-i, y-i):
                break
            else:
                ls.append(s + str(x) + str(y) + str(x-i) + str(y-i) + "UM")
                if board[y-i][x-i] != 0:
                    break
        for i in [1,2,3,4,5,6,7,8,9]:
            if boardout(x+i, y-i):
                break
            else:
                ls.append(s + str(x) + str(y) + str(x+i) + str(y-i) + "UM")
                if board[y-i][x+i] != 0:
                    break
        for i in [1,2,3,4,5,6,7,8,9]:
            if boardout(x-i, y+i):
                break
            else:
                ls.append(s + str(x) + str(y) + str(x-i) + str(y+i) + "UM")
                if board[y+i][x-i] != 0:
                    break
        for i in [1,2,3,4,5,6,7,8,9]:
            if boardout(x+i, y+i):
                return ls
            else:
                ls.append(s + str(x) + str(y) + str(x+i) + str(y+i) + "UM")
                if board[y+i][x+i]:
                    return ls
    else:
        for i in [1,2,3,4,5,6,7,8,9]:
            if boardout(x-i, y-i):
                break
            else:
                if y-i < 4 and s == "+":
                    ls.append(s + str(x) + str(y) + str(x-i) + str(y-i) + "UM")
                    if board[y-i][x-i] != 0:
                        break
                else:
                    ls.append(s + str(x) + str(y) + str(x-i) + str(y-i) + "KA")
                    if board[y-i][x-i] != 0:
                        break
                
        for i in [1,2,3,4,5,6,7,8,9]:
            if boardout(x+i, y-i):
                break
            else:
                if y-i < 4 and s == "+":
                    ls.append(s + str(x) + str(y) + str(x+i) + str(y-i) + "UM")
                    if board[y-i][x+i] != 0:
                        break
                else:
                    ls.append(s + str(x) + str(y) + str(x+i) + str(y-i) + "KA")
                    if board[y-i][x+i] != 0:
                        break
                        
        for i in [1,2,3,4,5,6,7,8,9]:
            if boardout(x-i, y+i):
                break
            else:
                if y+i > 6 and s == "-":
                    ls.append(s + str(x) + str(y) + str(x-i) + str(y+i) + "UM")
                    if board[y+i][x-i] != 0:
                        break
                else:
                    ls.append(s + str(x) + str(y) + str(x-i) + str(y+i) + "KA")
                    if board[y+i][x-i] != 0:
                        break
                    
        for i in [1,2,3,4,5,6,7,8,9]:
            if boardout(x+i, y+i):
                return ls
            else:
                if y+i > 6 and s == "-":
                    ls.append(s + str(x) + str(y) + str(x+i) + str(y+i) + "UM")
                    if board[y+i][x+i] != 0:
                        return ls
                else:
                    ls.append(s + str(x) + str(y) + str(x+i) + str(y+i) + "KA")
                    if board[y+i][x+i] != 0:
                        return ls
                
                
def ry(s, x, y, board):
    ls = []
    for i in [1,2,3,4,5,6,7,8,9]:
        if y-i == 0:
            break
        else:
            ls.append(s + str(x) + str(y) + str(x) + str(y-i) + "RY")
            if board[y-i][x] != 0:
                break
    for i in [1,2,3,4,5,6,7,8,9]:
        if y+i == 10:
            break
        else:
            ls.append(s + str(x) + str(y) + str(x) + str(y+i) + "RY")
            if board[y+i][x] != 0:
                break
    for i in [1,2,3,4,5,6,7,8,9]:
        if x-i == 0:
            break
        else:
            ls.append(s + str(x) + str(y) + str(x-i) + str(y) + "RY")
            if board[y][x-i] != 0:
                break
    for i in [1,2,3,4,5,6,7,8,9]:
        if x+i == 10:
            break
        else:
            ls.append(s + str(x) + str(y) + str(x+i) + str(y) + "RY")
            if board[y][x+i] != 0:
                break
                
    if not boardout(x-1,y-1):
        ls.append(s + str(x) + str(y) + str(x-1) + str(y-1) + "RY")
    if not boardout(x+1,y-1):
        ls.append(s + str(x) + str(y) + str(x+1) + str(y-1) + "RY")
    if not boardout(x-1,y+1):
        ls.append(s + str(x) + str(y) + str(x-1) + str(y+1) + "RY")
    if not boardout(x+1,y+1):
        ls.append(s + str(x) + str(y) + str(x+1) + str(y+1) + "RY")
        
    return ls
    
    
def um(s, x, y, board):
    ls = []
 
    for i in [1,2,3,4,5,6,7,8,9]:
        if boardout(x-i, y-i):
            break
        else:
            ls.append(s + str(x) + str(y) + str(x-i) + str(y-i) + "UM")
            if board[y-i][x-i] != 0:
                break
    for i in [1,2,3,4,5,6,7,8,9]:
        if boardout(x+i, y-i):
            break
        else:
            ls.append(s + str(x) + str(y) + str(x+i) + str(y-i) + "UM")
            if board[y-i][x+i] != 0:
                break
    for i in [1,2,3,4,5,6,7,8,9]:
        if boardout(x-i, y+i):
            break
        else:
            ls.append(s + str(x) + str(y) + str(x-i) + str(y+i) + "UM")
            if board[y+i][x-i] != 0:
                break
    for i in [1,2,3,4,5,6,7,8,9]:
        if boardout(x+i, y+i):
            break
        else:
            ls.append(s + str(x) + str(y) + str(x+i) + str(y+i) + "UM")
            if board[y+i][x+i]:
                break
                
    if not boardout(x-1, y):
        ls.append(s + str(x) + str(y) + str(x-1) + str(y) + "UM")
    if not boardout(x+1, y):
        ls.append(s + str(x) + str(y) + str(x+1) + str(y) + "UM")
    if not boardout(x, y+1):
        ls.append(s + str(x) + str(y) + str(x) + str(y+1) + "UM")
    if not boardout(x, y-1):
        ls.append(s + str(x) + str(y) + str(x) + str(y-1) + "UM")
        
    return ls


def effect(s, x, y, k, board):
    if k == "OU":
        return ou(s, x, y)
    elif k == "HI":
        return hi(s, x, y, board)
    elif k == "KA":
        return ka(s, x, y, board)
    elif k == "GI":
        return gi(s, x, y)
    elif k == "KE":
        return ke(s, x, y)
    elif k == "KY":
        return ky(s, x, y, board)
    elif k == "FU":
        return fu(s, x, y)
    elif k == "RY":
        return ry(s, x, y, board)
    elif k == "UM":
        return um(s, x, y, board)
    else:
        return ki(s, x, y, k)


def move(s, x, y, k, board):
    ls = ([e for e in effect(s, x, y, k, board)
          if (not boardout(int(e[3]), int(e[4])))
              and (len (e) == 7)
              and (not (board[int(e[4])][int(e[3])] != 0
                        and board[int(e[4])][int(e[3])][0] == s))])
    return ls
    

def s_move(s, board):
    ls = []
    for y in [1,2,3,4,5,6,7,8,9]:
        for x in [1,2,3,4,5,6,7,8,9]:
            if board[y][x] != 0 and board[y][x][0] == s:
                ls += (move(s, x, y, board[y][x][1]+board[y][x][2], board))
    return ls


def canput_fu(s, board):
    ls = []
    for x in [1,2,3,4,5,6,7,8,9]:
        for y in [1,2,3,4,5,6,7,8,9]:
            if board[y][x] == s+"FU":
                break
            elif y == 9:
                ls.append(x)
    
    return ls
            
            
def put (s, k, board):
    ls = []
    if s == "+" and k == "FU":
        xlist = canput_fu(s, board)
        for y in [2,3,4,5,6,7,8,9]:
            for x in xlist:
                if board[y][x] == 0:
                    ls.append("+00" + str(x) + str(y) + "FU")
    elif s == "-" and k == "FU":
        xlist = canput_fu(s, board)
        for y in [1,2,3,4,5,6,7,8]:
            for x in xlist:
                if board[y][x] == 0:
                    ls.append("-00" + str(x) + str(y) + "FU")
    elif s == "+" and k == "KY":
        for y in [2,3,4,5,6,7,8,9]:
            for x in [1,2,3,4,5,6,7,8,9]:
                if board[y][x] == 0:
                    ls.append("+00" + str(x) + str(y) + "KY")
    elif s == "-" and k == "KY":
        for y in [1,2,3,4,5,6,7,8]:
            for x in [1,2,3,4,5,6,7,8,9]:
                if board[y][x] == 0:
                    ls.append("-00" + str(x) + str(y) + "KY")
    elif s == "+" and k == "KE":
        for y in [3,4,5,6,7,8,9]:
            for x in [1,2,3,4,5,6,7,8,9]:
                if board[y][x] == 0:
                    ls.append("+00" + str(x) + str(y) + "KE")
    elif s == "-" and k == "KE":
        for y in [1,2,3,4,5,6,7]:
            for x in [1,2,3,4,5,6,7,8,9]:
                if board[y][x] == 0:
                    ls.append("-00" + str(x) + str(y) + "KE")
                       
    else:
        for y in [1,2,3,4,5,6,7,8,9]:
            for x in [1,2,3,4,5,6,7,8,9]:
                if board[y][x] == 0:
                    ls.append(s + "00" + str(x) + str(y) + k)
                    
    return ls
    
    
def s_put(s, board, hands, handg):
    ls = []
    if s == "+":
        for k in ["HI","KA","KI","GI","KE","KY","FU"]:
            if hands[k] != 0:
                ls += put(s, k, board)
    elif s == "-":
        for k in ["HI","KA","KI","GI","KE","KY","FU"]:
            if handg[k] != 0:
                ls += put(s, k, board)
    return ls
        
