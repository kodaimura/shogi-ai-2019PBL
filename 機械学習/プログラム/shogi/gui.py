import tkinter as tk
from tkinter import messagebox
import threading
import os

import time
from . import match

os.environ['TK_SILENCE_DEPRECATION'] = "1"

match.match_init()
AIS = match.AIS
PS = match.PS

Board = match.Board
HandS = match.HandS
HandG = match.HandG

koma_jp = dict(OU="王",HI="飛",KA="角",KI="金",GI="銀",KE="桂",KY="香",FU="歩",
               RY="龍",UM="馬",NG="成銀",NK="成桂",NY="成香",TO="と")


class GUI():
    def __init__(self):
        self.root = tk.Tk()
        self.switch = 0
        self.root.title("将棋pbl")
        self.root.geometry("760x580+300+100")
        self.make_board()
        
    def make_board(self):
        self.elem_keep = ""
        self.te = ""
        self.taglist = []
        
        self.board = tk.Canvas(self.root, width=580,height=580,bg="dark khaki")
        self.handAI = tk.Canvas(self.root, width=80,height=500,bg="dark khaki")
        self.handP = tk.Canvas(self.root, width=80,height=500,bg="dark khaki")
        
        self.handAI.pack(side='left')
        self.board.pack(side='left')
        self.handP.pack(side='left')
        
        if AIS == "-":
            for i, y in zip([1,2,3,4,5,6,7,8,9], range(20,501,60)):
                for j, x in zip([9,8,7,6,5,4,3,2,1], range(20,501,60)):
                    tag = str(j) + str(i)
                    self.taglist.append(tag)
                    self.board.create_rectangle((x,y,x+60,y+60), fill="dark khaki",
                                tags=tag)
        
        elif AIS == "+":
            for i, y in zip([9,8,7,6,5,4,3,2,1], range(20,501,60)):
                for j, x in zip([1,2,3,4,5,6,7,8,9], range(20,501,60)):
                    tag = str(j) + str(i)
                    self.taglist.append(tag)
                    self.board.create_rectangle((x,y,x+60,y+60), fill="dark khaki",
                                tags=tag)
                                
        for tag in self.taglist:
            self.board_set(tag)
        self.hand_set()
         
        self.match()
        self.binding()
        
    def match(self):
        if self.switch == 0 and AIS == "+":
            self.switch = 1
            #self.AIte()
            self.callback()
        elif self.switch == 1 and AIS == "-":
            self.switch = 0
            #self.AIte()
            self.callback()
        
    def board_set(self,tag):
        x = int(tag[0])
        y = int(tag[1])
        if AIS == "-":
            if Board[y][x] == 0:
                return 0
            elif Board[y][x][0] == AIS:
                self.board.create_text((10-x)*60-10,y*60-10, font=("Helvetica",25,"bold"),text= koma_jp[Board[y][x][1]+Board[y][x][2]])
            else:
                self.board.create_text((10-x)*60-10,y*60-10, font=("Helvetica",25,"bold"),text= koma_jp[Board[y][x][1]+Board[y][x][2]])
                
        else:
            if Board[y][x] == 0:
                return 0
            elif Board[y][x][0] == AIS:
                self.board.create_text(x*60-10,(10-y)*60-10, font=("Helvetica",25,"bold"),text= koma_jp[Board[y][x][1]+Board[y][x][2]])
            else:
                self.board.create_text(x*60-10,(10-y)*60-10, font=("Helvetica",25,"bold"),text= koma_jp[Board[y][x][1]+Board[y][x][2]])
                
    def hand_set(self):
        if AIS == "-":
            for i,k in zip(range(7),["HI","KA","KI","GI","KE","KY","FU"]):
                self.handAI.create_text(30, 500-50*(i+1), font=("Helvetica",25,"bold"),text=koma_jp[k]+str(HandG[k]))
                self.handP.create_text(30, 50*(i+1), font=("Helvetica",25,"bold"),text= koma_jp[k]+str(HandS[k]), tags=k)
        elif AIS == "+":
            for i,k in zip(range(7),["HI","KA","KI","GI","KE","KY","FU"]):
                self.handAI.create_text(30,500-50*(i+1),font=("Helvetica",25,"bold"),text= koma_jp[k]+str(HandS[k]))
                self.handP.create_text(30, 50*(i+1), font=("Helvetica",25,"bold"),text= koma_jp[k]+str(HandG[k]), tags=k)
                    
    def binding(self):
        for tag in self.taglist:
            self.board.tag_bind(tag, "<ButtonPress-1>", self.board_pressed)
        for k in ["HI","KA","KI","GI","KE","KY","FU"]:
            self.handP.tag_bind(k, "<ButtonPress-1>", self.hand_pressed)
            
    def board_pressed(self, event):
        id = self.board.find_closest(event.x, event.y)
        tag = self.board.gettags(id[0])[0]
        #self.board.itemconfigure('current',fill = "brown")
        print(tag)
        
        self.te_decide(tag)
        
        
    def hand_pressed(self,event):
        id = self.handP.find_closest(event.x,event.y)
        tag = self.handP.gettags(id[0])[0]
        print(tag)
        
        self.te_decide(tag)
        
    def te_decide(self,te_elem):
        
        global Board
        if te_elem == 'current':
            pass
        elif self.elem_keep == "" :
            if te_elem in ["HI","KA","KI","GI","KE","KY","FU"]:
                self.elem_keep = te_elem
            elif Board[int(te_elem[1])][int(te_elem[0])] != 0 and Board[int(te_elem[1])][int(te_elem[0])][0] == PS:
                self.elem_keep = te_elem
            else:
                pass
        elif self.elem_keep in ["HI","KA","KI","GI","KE","KY","FU"] and not te_elem in ["HI","KA","KI","GI","KE","KY","FU"]:
            if Board[int(te_elem[1])][int(te_elem[0])] == 0:
                self.te = PS + '00' + te_elem + self.elem_keep
                print(self.te)
                te = match.pte(PS,self.te)
                self.handAI.pack_forget()
                self.board.pack_forget()
                self.handP.pack_forget()
                if self.switch == 0:
                    self.switch =  1
                else:
                    self.switch =  0
              
                self.make_board()
                
            else:
                pass
                
        elif not self.elem_keep in ["HI","KA","KI","GI","KE","KY","FU"] and not te_elem in ["HI","KA","KI","GI","KE","KY","FU"] and self.elem_keep != te_elem:
             
            if Board[int(te_elem[1])][int(te_elem[0])] == 0 or Board[int(te_elem[1])][int(te_elem[0])][0] != PS:
            
                self.te = PS + self.elem_keep + te_elem + Board[int(self.elem_keep[1])][int(self.elem_keep[0])][1] + Board[int(self.elem_keep[1])][int(self.elem_keep[0])][2]
                print(self.te)
                te = match.pte(PS,self.te)
                if te == 1:
                    self.handAI.pack_forget()
                    self.board.pack_forget()
                    self.handP.pack_forget()
                
                    if self.switch == 0:
                        self.switch =  1
                    else:
                        self.switch =  0

                    self.make_board()
  
                else:
                    self.elem_keep = ""
                
            else:
                pass
        else:
            pass
            
    def AIte(self):
        t1 = time.time()
        te = match.aite()
        t2 = time.time()
        print(t2-t1)
        match.TE(te,Board,HandS,HandG)
        self.handAI.pack_forget()
        self.board.pack_forget()
        self.handP.pack_forget()
        self.make_board()
        
    def callback(self):
        th = threading.Thread(target = self.AIte)
        th.start()

    def run(self):
        self.root.mainloop()
