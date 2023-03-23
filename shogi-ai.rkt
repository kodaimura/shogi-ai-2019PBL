#lang racket

(require racket/date)
(define s1 0)
(define s2 0)
(set! s1 0)
(set! s2 0)

(define atom?
  (lambda (x)
    (and (not (pair? x))
         (not (null? x)))))
(define eqlist?
  (lambda (a b)
    (cond
    ((and (null? a) (null? b)) #t)
    ((or (null? a) (null? b)) #f)
    
    ((and (atom? (car a)) (atom? (car b)))
     (and (eq? (car a) (car b))
          (eqlist? (cdr a) (cdr b))))
    ((or (atom? (car a))
         (atom? (car b))) #f)
    (else (and (eqlist? (car a) (car b)) (eqlist? (cdr a) (cdr b)))))))

(define y0 (make-vector 40))
(define y1 (vector 1 0 0 0 0 0 0 0 0 0))
(define y2 (vector 2 0 0 0 0 0 0 0 0 0))
(define y3 (vector 3 0 0 0 0 0 0 0 0 0))
(define y4 (vector 4 0 0 0 0 0 0 0 0 0))
(define y5 (vector 5 0 0 0 0 0 0 0 0 0))
(define y6 (vector 6 0 0 0 0 0 0 0 0 0))
(define y7 (vector 7 0 0 0 0 0 0 0 0 0))
(define y8 (vector 8 0 0 0 0 0 0 0 0 0))
(define y9 (vector 9 0 0 0 0 0 0 0 0 0))
(define yvec (vector y0 y1 y2 y3 y4 y5 y6 y7 y8 y9))

(define 1tekeep '())
(define tekeep (make-vector 250))
(define timekeep (make-vector 250))

(define yn
  (lambda (n)
    (vector-ref yvec n)))

(define s->op
  (lambda (s)
    (if (= s 1) - +)))

(define ss
  (lambda (s)
    (if (= s 1) 0 1)))

(define x_y0
  (lambda (n)
    (if (eq? 0 (vector-ref y0 n)) n (x_y0 (+ n 1)))))

  
(define nariline? (lambda (s y) (or (and (= s 1) (< y 4)) (and (= s 0) (< 6 y)))))

(define Osyou
  (lambda (s x y k nari)
   (list (list s (- x 1) (- y 1) k 0) (list s (- x 1) y k 0)
         (list s (- x 1) (+ y 1) k 0) (list s x (- y 1) k 0) (list s x (+ y 1) k 0) (list s (+ x 1) (- y 1) k 0) (list s (+ x 1) y k 0) (list s (+ x 1) (+ y 1) k 0))))

(define Kin
  (lambda (s x y k nari)
    (list (list s (- x 1) y k nari) (list s x (- y 1) k nari)
          (list s x (+ y 1) k nari) (list s (+ x 1) y k nari) (list s (- x 1) ((s->op s) y 1) k nari) (list s (+ x 1) ((s->op s) y 1) k nari))))

(define Gin
  (lambda (s x y k nari)
    (cond
    ((nariline? s y) (list (list s (- x 1) (- y 1) k 0) (list s (- x 1) (+ y 1) k 0) (list s (+ x 1) (- y 1) k 0) (list s (+ x 1) (+ y 1) k 0) (list s x ((s->op s) y 1) k 0)
                           (list s (- x 1) (- y 1) k 1) (list s (- x 1) (+ y 1) k 1) (list s (+ x 1) (- y 1) k 1) (list s (+ x 1) (+ y 1) k 1) (list s x ((s->op s) y 1) k 1)))
    ((or (and (= s 1) (= y 4)) (and (= s 0) (= y 6))) (list (list s (- x 1) (- y 1) k 0) (list s (- x 1) (+ y 1) k 0) (list s (+ x 1) (- y 1) k 0) (list s (+ x 1) (+ y 1) k 0)
                                                            (list s x ((s->op s) y 1) k 0) (list s x ((s->op s) y 1) k 1) (list s (- x 1) ((s->op s) y 1) k 1) (list s (+ x 1) ((s->op s) y 1) k 1)))
    (else (list (list s (- x 1) (- y 1) k 0) (list s (- x 1) (+ y 1) k 0) (list s (+ x 1) (- y 1) k 0) (list s (+ x 1) (+ y 1) k 0) (list s x ((s->op s) y 1) k 0))))))

(define Keima
  (lambda (s x y k nari)
    (cond
    ((= y 5) (list (list s (- x 1) ((s->op s) y 2) k 0) (list s (+ x 1) ((s->op s) y 2) k 0) (list s (- x 1) ((s->op s) y 2) k 1) (list s (+ x 1) ((s->op s) y 2) k 1)))
    ((or (and (= s 1) (< y 5)) (and (= s 0) (< 5 y))) (list (list s (- x 1) ((s->op s) y 2) k 1) (list s (+ x 1) ((s->op s) y 2) k 1)))
    (else (list (list s (- x 1) ((s->op s) y 2) k 0) (list s (+ x 1) ((s->op s) y 2) k 0))))))

(define Fu
  (lambda (s x y k nari)
    (cond
    ((or (and (= s 1) (= y 2)) (and (= s 0) (= y 8))) (list (list s x ((s->op s) y 1) k 1)))
    ((or (and (= s 1) (< y 5)) (and (= s 0) (< 5 y))) (list (list s x ((s->op s) y 1) k 0) (list s x ((s->op s) y 1) k 1)))
    (else (list (list s x ((s->op s) y 1) k 0))))))

(define Kyosya
  (lambda (s x y k nari)
    (cond
      ((or (and (= s 1) (= y 1)) (and (= s 0) (= y 9))) (list (list s x y k 1)))
      ((exist? x y)
       (cond
         ((nariline? s y) (list (list s x y k 1) (list s x y k 0)))
         (else (list (list s x y k 0)))))
      ((and (nariline? s y) (= nari 0)) (cons (list s x y k 1) (Kyosya s x y k 1)))
      (else (cons (list s x y k 0) (Kyosya s x ((s->op s) y 1) k 0))))))

(define Hisya-aux
  (lambda (s x y k nari X Y ls m op Nari)
    (cond
     ((and (or (nariline? s Y) (nariline? s y)) (= nari 0) (not (= Nari 1))) (Hisya-aux s x y k 1 X Y (cons (list s x y k 1) ls) m op Nari))
     ((and (or (not (board? x y)) (exist? x y)) (= m 1)) (Hisya-aux s (+ X 1) Y k 0 X Y (cons (list s x y k Nari) ls) (+ m 1) + Nari))
     ((and (or (not (board? x y)) (exist? x y)) (= m 2)) (Hisya-aux s X (- Y 1) k 0 X Y (cons (list s x y k Nari) ls) (+ m 1) - Nari))
     ((and (or (not (board? x y)) (exist? x y)) (= m 3)) (Hisya-aux s X (+ Y 1) k 0 X Y (cons (list s x y k Nari) ls) (+ m 1) + Nari))
     ((and (or (not (board? x y)) (exist? x y)) (= m 4)) (cons (list s x y k Nari) ls))
     ((or (= m 1) (= m 2)) (Hisya-aux s (op x 1) y k 0 X Y (cons (list s x y k Nari) ls) m op Nari))
     ((or (= m 3) (= m 4)) (Hisya-aux s x (op y 1) k 0 X Y (cons (list s x y k Nari) ls) m op Nari)))))
(define Hisya (lambda (s x y k nari)
  (if (= nari 0) (Hisya-aux s (- x 1) y k nari x y '() 1 - nari)
      (append (list (list s (- x 1) (- y 1) k 1) (list s (- x 1) (+ y 1) k 1) (list s (+ x 1) (- y 1) k 1) (list s (+ x 1) (+ y 1) k 1)) (Hisya-aux s (- x 1) y k nari x y '() 1 - nari)))))

(define Kaku-aux
  (lambda (s x y k nari X Y ls m xop yop Nari)
    (cond
      ((and (or (nariline? s y) (nariline? s Y)) (= nari 0) (not (= Nari 1))) (Kaku-aux s x y k 1 X Y (cons (list s x y k 1) ls) m xop yop Nari))
      ((and (or (not (board? x y)) (exist? x y)) (= m 1)) (Kaku-aux s (+ X 1) (+ Y 1) k 0 X Y (cons (list s x y k Nari)ls) (+ m 1) + + Nari))
      ((and (or (not (board? x y)) (exist? x y)) (= m 2)) (Kaku-aux s (- X 1) (+ Y 1) k 0 X Y (cons (list s x y k Nari) ls) (+ m 1) - + Nari))
      ((and (or (not (board? x y)) (exist? x y)) (= m 3)) (Kaku-aux s (+ X 1) (- Y 1) k 0 X Y (cons (list s x y k Nari) ls) (+ m 1) + - Nari))
      ((and (or (not (board? x y)) (exist? x y)) (= m 4)) (cons (list s x y k Nari) ls))
      (else (Kaku-aux s (xop x 1) (yop y 1) k 0 X Y (cons (list s x y k Nari) ls) m xop yop Nari)))))
(define Kaku (lambda (s x y k nari)
   (if (= nari 0) (Kaku-aux s (- x 1) (- y 1) k nari x y '() 1 - - nari)
       (append (list (list s x (- y 1) k 1) (list s x (+ y 1) k 1) (list s (- x 1) y k 1) (list s (+ x 1) y k 1)) (Kaku-aux s (- x 1) (- y 1) k nari x y '() 1 - - nari)))))
     
(define board? (lambda (x y) (not (or (or (< 9 x) (< x 1)) (or (< 9 y) (< y 1))))))
(define exist? (lambda (x y) (not (eq? (vector-ref (yn y) x) 0))))

(define effect-aux 
  (lambda (s x y k nari)
    (cond
      ((eq? k "王") (Osyou s x y k nari))
      ((eq? k "飛") (Hisya s x y k nari))
      ((eq? k "角") (Kaku s x y k nari))
      ((or (eq? k "金") (= nari 1)) (Kin s x y k nari))
      ((eq? k "銀") (Gin s x y k nari))
      ((eq? k "桂") (Keima s x y k nari))
      ((eq? k "香") (Kyosya s x ((s->op s) y 1) k nari))
      ((eq? k "歩") (Fu s x y k nari)))))
(define effect
  (lambda (ls)
    (map (lambda (l) (append (list  (car ls) (cadr ls) (caddr ls) (cadddr ls) (fifth ls)) l))
                              (filter (lambda (L) (board? (cadr L) (caddr L))) (effect-aux (car ls) (cadr ls) (caddr ls) (cadddr ls) (fifth ls))))))

(define move-aux
  (lambda (lls l)
    (cond
      ((null? lls) l)
      ((and (exist? (seventh (car lls)) (eighth (car lls)))
            (eq? (caar lls) (car (vector-ref (yn (eighth (car lls))) (seventh (car lls)))))) (move-aux (cdr lls) l))
      (else (move-aux (cdr lls) (cons (car lls) l))))))

(define move
  (lambda (ls)
    (move-aux (effect ls) '())))
; ls: '(s x y k nari)

(define nifu?
  (lambda (s x n)
    (cond
      ((= n 10) #f)
      ((and (exist? x n) (eq? "歩" (cadddr (vector-ref (yn n) x))) (= s (car (vector-ref (yn n) x))) (= 0 (fifth (vector-ref (yn n) x)))) #t)
      (else (nifu? s x (+ n 1))))))

(define canput-aux
  (lambda (s x k l ylist xlist)
       (begin (for ([i xlist])
         (cond
          ((and (eq? k "歩") (nifu? s i 1)) #f)
          ((and (or (eq? k "歩") (eq? k "香")) (= s 1))
                (for ([j ylist] #:unless (= j 1))
                  (if (exist? i j) #f (set! l (cons (list s x 0 k 0 s i j k 0) l)))))
          ((and (or (eq? k "歩") (eq? k "香")) (= s 0))
                (for ([j ylist] #:unless (= j 9))
                  (if (exist? i j) #f (set! l (cons (list s x 0 k 0 s i j k 0) l)))))
          ((and (eq? k "桂") (= s 1))
                (for ([j ylist] #:unless (< j 3))
                  (if (exist? i j) #f (set! l (cons (list s x 0 k 0 s i j k 0) l)))))
          ((and (eq? k "桂") (= s 0))
                (for ([j ylist] #:unless (> j 7))
                  (if (exist? i j) #f (set! l (cons (list s x 0 k 0 s i j k 0) l)))))
          (else (for ([j ylist])
                  (if (exist? i j) #f (set! l (cons (list s x 0 k 0 s i j k 0) l))))))) l)))

(define xy_canput
  (lambda (ls ylist xlist)
    (canput-aux (car ls) (cadr ls) (cadddr ls) '() ylist xlist)))

(define s_mp
  (lambda (s)
    (append (s_hika_mp s '() '()) (s_xy_mp-aux s '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9) '() '()))))

(define s_xy_mp-aux
  (lambda (s ylist xlist l ls)
    (for ([k (range 35)])
      (if (and (exist? k 0) (eq? (car (vector-ref y0 k)) s) (not (member (fourth (vector-ref y0 k)) ls))
          (not (or (eq? (fourth (vector-ref y0 k)) "角") (eq? (fourth (vector-ref y0 k)) "飛"))))
          (begin (set! l (append (xy_canput (vector-ref y0 k) ylist xlist) l))
                 (set! ls (cons (fourth (vector-ref y0 k)) ls))) #f))       
    (for ([i ylist])
      (for ([j xlist])
        (if (and (exist? j i) (eq? (car (vector-ref (yn i) j)) s)
                 (not (or (eq? (fourth (vector-ref (yn i) j)) "角") (eq? (fourth (vector-ref (yn i) j)) "飛"))))
            (set! l (append (move (vector-ref (yn i) j)) l)) #f))) l))

(define s_xy_p-aux
  (lambda (s ylist xlist l ls)
    (for ([k (range 35)])
      (if (and (exist? k 0) (eq? (car (vector-ref y0 k)) s) (not (member (fourth (vector-ref y0 k)) ls))
          (not (or (eq? (fourth (vector-ref y0 k)) "角") (eq? (fourth (vector-ref y0 k)) "飛"))))
          (begin (set! l (append (xy_canput (vector-ref y0 k) ylist xlist) l))
                 (set! ls (cons (fourth (vector-ref y0 k)) ls))) #f)) l))

(define s_xy_p
  (lambda (s ylist xlist)
    (s_xy_p-aux s ylist xlist '() '())))

(define s_xy_m-aux
  (lambda (s ylist xlist l)
    (for ([i ylist])
      (for ([j xlist])
        (if (and (exist? j i) (eq? (car (vector-ref (yn i) j)) s)
                 (not (or (eq? (fourth (vector-ref (yn i) j)) "角") (eq? (fourth (vector-ref (yn i) j)) "飛"))))
            (set! l (append (move (vector-ref (yn i) j)) l)) #f))) l))

(define s_xy_m
  (lambda (s ylist xlist)
    (s_xy_m-aux s ylist xlist '())))


(define s_hika_m
  (lambda (s l)    
    (for ([i '(1 2 3 4 5 6 7 8 9)])
      (for ([j '(1 2 3 4 5 6 7 8 9)])
        (if (and (exist? j i) (eq? (car (vector-ref (yn i) j)) s)
                 (or (eq? (fourth (vector-ref (yn i) j)) "角")
                     (eq? (fourth (vector-ref (yn i) j)) "飛")))
            (set! l (append (move (vector-ref (yn i) j)) l)) #f))) l))

(define s_hika_mp
  (lambda (s l ls)
    (for ([k (range 35)])
      (if (and (exist? k 0) (eq? (car (vector-ref y0 k)) s)
               (not (member (fourth (vector-ref y0 k)) ls))
               (or (eq? (fourth (vector-ref y0 k)) "角") (eq? (fourth (vector-ref y0 k)) "飛")))
                   (cond
                     ((= s 1) (begin (set! l (append (xy_canput (vector-ref y0 k)
                                                     '(1 2 3 4 5 6) '(1 2 3 4 5 6 7 8 9)) l))
                          (set! ls (cons (fourth (vector-ref y0 k)) ls))))
                     ((= s 0) (begin (set! l (append (xy_canput (vector-ref y0 k)
                                                     '(4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9)) l))
                          (set! ls (cons (fourth (vector-ref y0 k)) ls)))))
                              #f))
    (append l (s_hika_m s l)) l))

(define s_effect-aux
  (lambda (s ylist xlist l)
    (for ([i ylist])
      (for ([j xlist])
        (if (and (exist? j i) (eq? (car (vector-ref (yn i) j)) s)) (set! l (append (effect (vector-ref (yn i) j)) l)) #f))) l))

(define s_xy_effect
  (lambda (s ylist xlist)
    (s_effect-aux s ylist xlist'())))

(define N 0)

(define 1te-aux
  (lambda (s ox oy x y ls)
    (cond
      ((and (eq? "王" (cadddr (vector-ref (yn oy) ox))) (begin (set_oposi s (cdr (cddddr ls))) #f)))
      ((exist? x y)
       (cond
         ((and(eq? "王" (cadddr (vector-ref (yn y) x))) (begin (set_oposi (ss s) (cdr (cddddr ls))) #f)))
          (else
           (begin (set! 1tekeep (list ls (append (vector-ref (yn y) x) (list s (x_y0 1) 0 (cadddr (vector-ref (yn y) x)) 0))))
                           (vector-set! tekeep (+ N 1) 1tekeep)
                           (vector-set! y0 (x_y0 1) (list s (x_y0 1) 0 (cadddr (vector-ref (yn y) x)) 0))
                           (vector-set! (yn y) x (cdr (cddddr ls)))
                           (vector-set! (yn oy) ox 0)))))
      (else (begin (vector-set! (yn y) x (cdr (cddddr ls))) (vector-set! (yn oy) ox 0) (set! 1tekeep (list ls)) (vector-set! tekeep (+ N 1) 1tekeep))))))

(define 1te
  (lambda (ls)
    (begin (1te-aux (car ls) (cadr ls) (caddr ls) (seventh ls) (eighth ls) ls)  (set! N (+ N 1)))))


(define back
  (lambda (s ox oy k onari x y)
    (begin (vector-set! (yn oy) ox (list s ox oy k onari)) (vector-set! (yn y) x 0))))

(define 1teback-aux
  (lambda (lls)
    (cond
    ((null? lls) (vector-set! tekeep N 0))
    ((and (eq? (cadddr (car lls)) "王") (begin (set_oposi (caar lls) (list (caar lls) (cadar lls) (caddar lls) "王" 0)) #f))) 
    (else (begin (back (first (car lls)) (cadr (car lls)) (caddr (car lls)) (cadddr (car lls)) (fifth (car lls))
                              (seventh (car lls)) (eighth (car lls)))
                 (1teback-aux (cdr lls)))))))

(define 1teback
  (lambda ()
    (begin (1teback-aux (vector-ref tekeep N)) (set! N (- N 1)))))


(define oposi1 '(1 5 9 "王" 0))
(define oposi0 '(0 5 1 "王" 0))

(define oposi
  (lambda (s)
    (if (= s 1) oposi1 oposi0)))

(define set_oposi
  (lambda (s oposi)
    (if (= s 1) (set! oposi1 oposi) (set! oposi0 oposi))))


(define Ote?-aux4
  (lambda (s x y n m)
    (cond
      ((= n 11)
       (cond
         ((not (board? x ((s->op (ss s)) y m))) (Ote?-aux4 s x y 12 1))
         ((exist? x ((s->op (ss s)) y m))
          (cond
            ((and (= (car (vector-ref (yn ((s->op (ss s)) y m)) x)) s)
             (or (and (eq? (cadddr (vector-ref (yn ((s->op (ss s)) y m)) x)) "香") (= (fifth (vector-ref (yn ((s->op (ss s)) y m)) x)) 0))
                 (eq? (cadddr (vector-ref (yn ((s->op (ss s)) y m)) x)) "飛"))) #t)
            (else (Ote?-aux4 s x y 12 1))))
         (else (Ote?-aux4 s x y n (+ m 1)))))
      
      ((= n 12)
       (cond
         ((not (board? x ((s->op s) y m))) (Ote?-aux4 s x y 13 1))
         ((exist? x ((s->op s) y m))
          (cond
           ((and (= (car (vector-ref (yn ((s->op s) y m)) x)) s) (eq? (cadddr (vector-ref (yn ((s->op s) y m)) x)) "飛")) #t)
           (else (Ote?-aux4 s x y 13 1))))
         (else (Ote?-aux4 s x y n (+ m 1)))))
      
      ((= n 13)
       (cond
         ((not (board? (- x m) y)) (Ote?-aux4 s x y 14 1))
         ((exist? (- x m) y)
          (cond
           ((and (= (car (vector-ref (yn y) (- x m))) s) (eq? (cadddr (vector-ref (yn y) (- x m))) "飛")) #t)
           (else (Ote?-aux4 s x y 14 1))))
         (else (Ote?-aux4 s x y n (+ m 1)))))
      
      ((= n 14)
       (cond
         ((not (board? (+ x m) y)) (Ote?-aux4 s x y 15 1))
         ((exist? (+ x m) y)
          (cond
           ((and (= (car (vector-ref (yn y) (+ x m))) s) (eq? (cadddr (vector-ref (yn y) (+ x m))) "飛")) #t)
           (else (Ote?-aux4 s x y 15 1))))
         (else (Ote?-aux4 s x y n (+ m 1)))))
      
      ((= n 15)
       (cond
         ((not (board? (+ x m) (+ y m))) (Ote?-aux4 s x y 16 1))
         ((exist? (+ x m) (+ y m))
          (cond
           ((and (= (car (vector-ref (yn (+ y m)) (+ x m))) s) (eq? (cadddr (vector-ref (yn (+ y m)) (+ x m))) "角")) #t)
           (else (Ote?-aux4 s x y 16 1))))
         (else (Ote?-aux4 s x y n (+ m 1)))))
      
      ((= n 16)
       (cond
         ((not (board? (+ x m) (- y m))) (Ote?-aux4 s x y 17 1))
         ((exist? (+ x m) (- y m))
          (cond
           ((and (= (car (vector-ref (yn (- y m)) (+ x m))) s) (eq? (cadddr (vector-ref (yn (- y m)) (+ x m))) "角")) #t)
           (else (Ote?-aux4 s x y 17 1))))
         (else (Ote?-aux4 s x y n (+ m 1)))))
      
      ((= n 17)
       (cond
         ((not (board? (- x m) (+ y m))) (Ote?-aux4 s x y 18 1))
         ((exist? (- x m) (+ y m))
          (cond
           ((and (= (car (vector-ref (yn (+ y m)) (- x m))) s) (eq? (cadddr (vector-ref (yn (+ y m)) (- x m))) "角")) #t)
           (else (Ote?-aux4 s x y 18 1))))
         (else (Ote?-aux4 s x y n (+ m 1)))))
      
      ((= n 18)
       (cond
         ((not (board? (- x m) (- y m))) #f)
         ((exist? (- x m) (- y m))
          (cond
           ((and (= (car (vector-ref (yn (- y m)) (- x m))) s) (eq? (cadddr (vector-ref (yn (- y m)) (- x m))) "角")))
           (else #f)))
         (else (Ote?-aux4 s x y n (+ m 1))))))))
     

(define Ote?-aux3
  (lambda (k nari n)
    (cond
     ((or (= n 1) (= n 2) (= n 3)) (or (eq? k "金") (= nari 1) (and (eq? k "角") (= nari 1))))
     ((or (= n 4) (= n 5)) (or (and (eq? k "銀") (= nari 0)) (and (eq? k "飛") (= nari 1))))
     ((or (= n 6) (= n 7)) (and (eq? k "桂") (= nari 0)))
     ((or (= n 8) (= n 9)) (or (eq? k "金") (eq? k "銀") (= nari 1) (and (eq? k "飛") (= nari 1))))
     ((= n 10) (or (eq? k "歩") (eq? k "金") (eq? k "銀") (= nari 1))))))

(define Ote?-aux2
  (lambda (s x y n)
    (if (and (board? x y) (exist? x y) (= (car (vector-ref (yn y) x)) s))
        (Ote?-aux3 (cadddr (vector-ref (yn y) x)) (fifth (vector-ref (yn y) x)) n)
        #f)))
                               
(define Ote?-aux1
  (lambda (s ox oy)
    (cond
      ((Ote?-aux2 s (- ox 1) oy 1) #t)
      ((Ote?-aux2 s (+ ox 1) oy 2) #t)
      ((Ote?-aux2 s ox ((s->op s) oy 1) 3) #t)
      ((Ote?-aux2 s (- ox 1) ((s->op s) oy 1) 4) #t)
      ((Ote?-aux2 s (+ ox 1) ((s->op s) oy 1) 5) #t)
      ((Ote?-aux2 s (- ox 1) ((s->op (ss s)) oy 2) 6) #t)
      ((Ote?-aux2 s (+ ox 1) ((s->op (ss s)) oy 2) 7) #t)
      ((Ote?-aux2 s (- ox 1) ((s->op (ss s)) oy 1) 8) #t)
      ((Ote?-aux2 s (+ ox 1) ((s->op (ss s)) oy 1) 9) #t)
      ((Ote?-aux2 s ox ((s->op (ss s)) oy 1) 10) #t)
      ((Ote?-aux4 s ox oy 11 1) #t)
      (else #f))))
      
(define Ote?
  (lambda (s)
    (Ote?-aux1 s (cadr (oposi (ss s))) (caddr (oposi (ss s))))))

       
(define escapeOte-aux
  (lambda (s lls l)
    (cond
    ((null? lls) l)
    ((begin (1te (car lls)) #f))
    ((not (Ote? (ss s))) (begin (1teback) (escapeOte-aux s (cdr lls) (cons (car lls) l))))
    (else (begin (1teback) (escapeOte-aux s (cdr lls) l))))))

(define escapeOte
  (lambda (s)
    (escapeOte-aux s (s_mp s) '())))

;以下main
(define A -20000)
(define B 20000)
(define AB (vector B A B A B A B A B A B))
(define BEST_1te '())
(define part 1)
;ply:読みの深さ
(define ply 2)


;以下で最善手を決める
;(alphabeta)にAI側のside 1or0 (先手or後手)を入れて呼び出す。
;AIthink Pthink を再帰的に呼び出し、それぞれの手を検証する。
;Aithink,Pthinkの引数はside(先手or後手),lls(階層nにおけるすべての候補手のリスト),n(階層),X(現在考えてる手の元の一手)
;読みの深さn=1から n=plyまで調べ、n=plyの時(evaluate)で盤面を評価する。
;読みの途中(< n ply)で詰みの手があればその時点で評価値10000とする。
;評価値が決まると(minmax),(keep_max),(keep_min)らを使いminmax法
;(minmax),(keep_max),(keep_min)はそれぞれの階層でのminやmaxを保存する。保存先はAB
;保存したminやmaxを新しい評価値と比較することで、Acut,Bcut(AB法)を行う。


;(s ox oy k onari x y nari)

(define keep_max
  (lambda (n value)
    (if (< (vector-ref AB n) value) (vector-set! AB n value) #f)))

(define keep_min
  (lambda (n value)
    (if (> (vector-ref AB n) value) (vector-set! AB n value) #f)))

(define evec (make-vector 250))

(define minmax
  (lambda (n X)
    (cond
      ((and (= n 2) (< (vector-ref AB 1) (vector-ref AB 2)) (begin (set! BEST_1te X) #f)))
      ((= n 1) (begin (println (vector-ref AB 1)) (vector-set! evec N (vector-ref AB 1)) (vector-set! AB 1 A)))
      ((odd? n) (begin (keep_min (- n 1) (vector-ref AB n)) (vector-set! AB n A)))
      ((even? n) (begin (keep_max (- n 1) (vector-ref AB n)) (vector-set! AB n B))))))

(define Acut?
  (lambda (n)
    (if (< (- (vector-ref AB n) 1) (vector-ref AB (- n 1))) #t #f)))

(define Bcut?
  (lambda (n)
    (if (> (+ (vector-ref AB n) 1) (vector-ref AB (- n 1))) #t #f)))

(define AIthink
  (lambda (s lls n X)
    (cond
      ((Bcut? n) (begin (vector-set! AB n A) #t))
      ((null? lls) (begin (minmax n X) #t))

      ((and (= n 1) (set! X (car lls)) #f))

      ((and (= (caddar lls) 0) (eq? (fourth (car lls)) "歩")
            (= (cadr (oposi (ss s))) (seventh (car lls))) (= (caddr (oposi (ss s))) ((s->op s) 1 (eighth (car lls)))))
       (AIthink s (cdr lls) n X))
      
      ((begin (1te (car lls)) #f))
      
      ((= n ply) (begin (keep_max n (evaluate AIside)) (1teback) (AIthink s (cdr lls) n X)))

      ((and (= part 3) (= n 1)
            (Pthink (ss s) (append (s_xy_m (ss s) '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))
                                                 (append (s_hika_mp (ss s) '() '())
                                                         (s_xy_p (ss s) (yrange_attack (ss s) (caddr (oposi s)))
                                                                   (xrange_attack (ss s) (cadr (oposi s)))))) (+ n 1) X))
            (begin (1teback) (AIthink s (cdr lls) n X)))

      ((and (= ply 4) (= n 1)
          (Pthink (ss s) (append (s_xy_m (ss s) '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))
                              (append (s_hika_m (ss s) '())
                                 (append (put_when_defense (ss s) '() '())
                                         (put_when_attack (ss s) '() '())))) (+ n 1) X))
            (begin (1teback) (AIthink s (cdr lls) n X)))

      ((and (= ply 5) (= n 1)
          (Pthink (ss s) (append (s_xy_m (ss s) '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))
                              (append (s_hika_m (ss s) '())
                                 (put_when_defense (ss s) '() '()))) (+ n 1) X))
            (begin (1teback) (AIthink s (cdr lls) n X)))

      ((and (or (= ply 4) (= ply 5)) (= n 3)
          (Pthink (ss s) (append (s_hika_m (ss s) '())
                                 (s_xy_m (ss s) '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))) (+ n 1) X))                                                  
           (begin (1teback) (AIthink s (cdr lls) n X)))

      ((Pthink (ss s) (s_mp (ss s)) (+ n 1) X) (begin (1teback) (AIthink s (cdr lls) n X))))))


(define Pthink
  (lambda (s lls n X)
    (cond
      ((Acut? n) (begin (vector-set! AB n B) #t))
      ((null? lls) (begin (minmax n X) #t))

      ((and (= (caddar lls) 0) (eq? (fourth (car lls)) "歩")
            (= (cadr (oposi (ss s))) (seventh (car lls))) (= (caddr (oposi (ss s))) ((s->op s) 1 (eighth (car lls)))))
       (Pthink s (cdr lls) n X))
      
      ((and (= n 4) (or (eq? (fourth (car lls)) "飛") (eq? (fourth (car lls)) "角"))
            (Ote?-aux1 AIside (seventh (car lls)) (eighth (car lls))))
       (Pthink s (cdr lls) n X))

      ((and (= n 4) (or (= part 2) (= part 3)) (not (= (vector-ref AB 4) B))
            (and (not (exist? (seventh (car lls)) (eighth (car lls))))
                 (= 0 (tenth (car lls))))) (Pthink s (cdr lls) n X))
      
      ((begin (1te (car lls)) #f))
     
      ((= n ply) (begin (keep_min n (evaluate AIside)) (1teback) (Pthink s (cdr lls) n X)))

      ((and (= ply 5) (AIthink (ss s) (append (s_hika_m (ss s) '())
                                              (append (s_xy_m (ss s) '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9)))) (+ n 1) X))
       (begin (1teback) (Pthink s (cdr lls) n X)))

      ((and (= part 3)
            (AIthink (ss s) (append (s_xy_m (ss s) '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))
                                                 (append (s_hika_m (ss s) '())
                                                         (s_xy_p (ss s) (yrange_defense (ss s) (caddr (oposi (ss s))))
                                                                   (xrange_defense (ss s) (cadr (oposi (ss s))))))) (+ n 1) X))
            (begin (1teback) (Pthink s (cdr lls) n X)))

      ((AIthink (ss s) (append (s_hika_m (ss s) '())
                               (append (put_when_defense (ss s) '() '())
                                       (s_xy_m (ss s) '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9)))) (+ n 1) X)
            (begin (1teback) (Pthink s (cdr lls) n X))))))
      
       
(define alphabeta
  (lambda (s)
    (cond
      ((and (Ote? (ss s)) (begin (set! part 3) #t))
       (cond
         ((null? (escapeOte s)) (display "参りました"))
         ((AIthink s (escapeOte s) 1 '()) (begin (println BEST_1te) (1te BEST_1te)))))

      ((and (= part 3)
            (AIthink s (append (s_xy_m s '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))
                                                 (append (s_hika_mp s '() '())
                                                   (append (s_xy_p s (yrange_attack s (caddr (oposi (ss s))))
                                                                   (xrange_attack s (cadr (oposi (ss s)))))
                                                           (s_xy_p s (yrange_defense s (caddr (oposi s)))
                                                                   (xrange_defense s (cadr (oposi s))))))) 1 '()))
            (begin (println BEST_1te) (1te BEST_1te)))
      
      ((and (= ply 4) (= s 1)
       (AIthink s (append (s_hika_mp s '() '())
                          (append (s_xy_m s '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))
                                    (s_xy_p s '(1 2 3 4 5 6 7 8) '(2 3 4 5 6 7 8 9)))) 1 '()))
            (begin (println BEST_1te) (1te BEST_1te)))

      ((and (= ply 4) (= s 0)
       (AIthink s (append (s_hika_mp s '() '())
                          (append (s_xy_m s '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))
                                    (s_xy_p s '(2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8)))) 1 '()))
            (begin (println BEST_1te) (1te BEST_1te)))

      ((and (= ply 5) (= s 1)
       (AIthink s (append (s_hika_m s '())
                          (append (s_xy_m s '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))
                                    (s_xy_p s '(1 2 3 4 5 6 7 8) '(2 3 4 5 6 7 8)))) 1 '()))
            (begin (println BEST_1te) (1te BEST_1te)))

      ((and (= ply 5) (= s 0)
       (AIthink s (append (s_hika_m s '())
                          (append (s_xy_m s '(1 2 3 4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))
                                    (s_xy_p s '(2 3 4 5 6 7 8 9) '(2 3 4 5 6 7 8)))) 1 '()))
            (begin (println BEST_1te) (1te BEST_1te)))
    
      ((AIthink s (s_mp s) 1 '()) (begin (println BEST_1te) (1te BEST_1te))))))

(define check
  (lambda ()
    (for ([i (range 10)])
      (if (= i 0) (println y0)
          (println (reverse (vector->list (yn i))))))))

(define kifprint
  (lambda (s ox oy k on x y nari n)
    (cond
      ((= oy 0) (displayln (format "~a 0 0 ~a ~a ~a  :~a" s x y k (vector-ref timekeep n))))
      ((and (= on 0) (= nari 1)) (displayln (format "~a ~a ~a ~a ~a 1　 :~a" s ox oy x y (vector-ref timekeep n))))
      (else (displayln (format "~a ~a ~a ~a ~a    :~a" s ox oy x y (vector-ref timekeep n)))))))

(define formatchange
  (lambda (n)
    (cond
      ((eq? (vector-ref tekeep n) 0) (begin (displayln N) #t))
      (else (begin (kifprint (first (car (vector-ref tekeep n))) (second (car (vector-ref tekeep n)))
                             (third (car (vector-ref tekeep n))) (fourth (car (vector-ref tekeep n)))
                             (fifth (car (vector-ref tekeep n))) (seventh (car (vector-ref tekeep n)))
                             (eighth (car (vector-ref tekeep n))) (tenth (car (vector-ref tekeep n))) n)
                   (formatchange (+ n 1)))))))

(define timer-start
  (lambda ()
    (set! s1 (current-inexact-milliseconds))))
(define timer-stop
  (lambda ()
    (begin (set! s2 (current-inexact-milliseconds))
           (displayln (format "time: ~as" (/ (round (/ (- s2 s1) 100)) 10)))
           (vector-set! timekeep N (/ (round (/ (- s2 s1) 100)) 10)))))

(define kif
  (lambda ()
    (formatchange 1)))

(define eng->jap
  (lambda (k_eng)
    (cond
      ((eq? k_eng 'o) "王")
      ((eq? k_eng 'hi) "飛")
      ((eq? k_eng 'ka) "角")
      ((eq? k_eng 'ki) "金")
      ((eq? k_eng 'gi) "銀")
      ((eq? k_eng 'ke) "桂")
      ((eq? k_eng 'ky) "香")
      ((eq? k_eng 'fu) "歩")
      (else #f))))

(define P1te
  (lambda (s te n)
    (cond
      ((= n 35) #f)
      ((and (= 4 (length te)) (exist? (car te) (cadr te)) (= s (car (vector-ref (yn (cadr te)) (car te))))
            (or (not (exist? (caddr te) (cadddr te))) (not (= s (car (vector-ref (yn (cadddr te)) (caddr te)))))))
       (1te (append (vector-ref (yn (cadr te)) (car te))
                    (list s (caddr te) (cadddr te) (fourth (vector-ref (yn (cadr te)) (car te))) (fifth (vector-ref (yn (cadr te)) (car te)))))))
      ((and (= 5 (length te)) (exist? (car te) (cadr te)) (= s (car (vector-ref (yn (cadr te)) (car te))))
            (or (not (exist? (caddr te) (cadddr te))) (not (= s (car (vector-ref (yn (cadddr te)) (caddr te)))))))
       (1te (append (vector-ref (yn (cadr te)) (car te))
                    (list s (caddr te) (cadddr te) (fourth (vector-ref (yn (cadr te)) (car te))) 1))))
      ((and (= 3 (length te)) (not (integer? (caddr te))))
            (cond
              ((and (exist? n 0) (eq? (eng->jap (caddr te)) (fourth (vector-ref y0 n))) (= s (first (vector-ref y0 n))))
                 (1te (append (vector-ref y0 n)
                              (list s (car te) (cadr te) (fourth (vector-ref y0 n)) 0))))
              (else (P1te s te (+ n 1)))))
      (else #f))))
  
(define match-aux
  (lambda (te)
    (cond
      ((begin (set! te (read)) #f))
      ((and (> N 45) (begin (set! part 2) #f)))
      ((eq? te '1r) (begin (1teback) (match-aux '())))
      ((eq? te '2r) (begin (1teback) (1teback) (match-aux '()))) 
      ((eq? te 'c) (begin (check) (match-aux '())))
      ((eq? te 'N) (begin (print N) (match-aux '())))
      ((eq? te 'e) (begin (print (evaluate AIside)) (match-aux '())))
      ((eq? te 'k) (begin (kif) (match-aux '())))
      ((P1te (ss AIside) te 1)
       (cond
        ((begin (timer-start) #f))
        ((and (> N 16) (= (vector-ref evec (- N 2)) (vector-ref evec (- N 6)) (vector-ref evec (- N 10))))
              (begin (set! ply 5) (alphabeta AIside) (timer-stop) (match-aux '())))
        ((and (> N 16) (= (vector-ref evec (- N 2)) (vector-ref evec (- N 6)) (vector-ref evec (- N 10))))
              (begin (set! ply 5) (alphabeta AIside) (timer-stop) (match-aux '())))
        ((and (< N 6)) (begin (alphabeta AIside) (timer-stop) (match-aux '())))
        ((and (> N 28) (tumu? AIside)) (begin (println tumi_1te) (1te tumi_1te) (timer-stop) (match-aux '())))
        ((and (> N 28) (tumu? (ss AIside)) (escapetumi? AIside) (AIthink AIside escape_te 1 '()))
         (begin (println BEST_1te) (1te BEST_1te) (timer-stop) (match-aux '())))
        ((< 6660 (abs (evaluate AIside))) (begin  (set! ply 4) (alphabeta AIside) (timer-stop) (match-aux '()))) 
        (else (begin (set! ply 4) (alphabeta AIside) (timer-stop) (match-aux '()))))) 
      (else (begin (print "もう一度") (match-aux '()))))))

(define match
  (lambda ()
    (if (= AIside 1) (begin (1te '(1 7 7 "歩" 0 1 7 6 "歩" 0)) (println '(1 7 7 "歩" 0 1 7 6 "歩" 0)) (match-aux '()))
                     (begin (set! ply 4) (match-aux '())))))

(define M
  (lambda ()
    (match-aux '())))

(define eval1
  (lambda (sum)
    (cond
      ((and (exist? 8 8) (eq? (fourth (vector-ref y8 8)) "銀") (begin (set! sum (+ sum 20)) #f)))
      ((and (exist? 8 8) (eq? (fourth (vector-ref y8 8)) "角") (begin (set! sum (+ sum 8)) #f)))
      ((and (exist? 7 8) (eq? (fourth (vector-ref y8 7)) "金") (begin (set! sum (+ sum 300)) #f)))
      ((and (exist? 5 8) (eq? (fourth (vector-ref y8 5)) "金") (begin (set! sum (+ sum 13)) #f)))
      ((and (exist? 6 8) (eq? (fourth (vector-ref y8 6)) "金") (begin (set! sum (+ sum 12)) #f)))
      ((and (exist? 4 8) (eq? (fourth (vector-ref y8 4)) "銀") (begin (set! sum (+ sum 10)) #f)))
      ((and (exist? 6 9) (eq? (fourth (vector-ref y9 6)) "王") (begin (set! sum (+ sum 6)) #f)))
      ((and (exist? 7 9) (eq? (fourth (vector-ref y9 7)) "王") (begin (set! sum (+ sum 8)) #f)))
      ((and (exist? 8 8) (eq? (fourth (vector-ref y8 8)) "王") (begin (set! sum (+ sum 20)) #f)))
      ((and (exist? 2 6) (eq? (fourth (vector-ref y6 2)) "歩") (begin (set! sum (+ sum 10)) #f)))
      ((and (exist? 2 5) (eq? (fourth (vector-ref y5 2)) "歩") (begin (set! sum (+ sum 16)) #f)))
      ((and (exist? 4 6) (eq? (fourth (vector-ref y6 4)) "歩") (begin (set! sum (+ sum 4)) #f)))
      ((and (exist? 4 7) (eq? (fourth (vector-ref y7 4)) "銀") (begin (set! sum (+ sum 10)) #f)))
      ((and (exist? 5 6) (eq? (fourth (vector-ref y6 5)) "銀") (begin (set! sum (+ sum 12)) #f)))
      ((and (exist? 5 7) (eq? (fourth (vector-ref y7 5)) "歩") (begin (set! sum (+ sum 100)) #f)))
      ((and (exist? 6 7) (eq? (fourth (vector-ref y7 6)) "歩") (begin (set! sum (+ sum 30)) #f)))
      ((and (exist? 7 6) (eq? (fourth (vector-ref y6 7)) "歩") (begin (set! sum (+ sum 30)) #f)))
      ((and (exist? 8 7) (eq? (fourth (vector-ref y7 8)) "歩") (begin (set! sum (+ sum 50)) #f)))
      ((and (exist? 2 4) (eq? (fourth (vector-ref y4 2)) "飛") (begin (set! sum (+ sum 90)) #f)))
      ((and (exist? 1 8) (eq? (fourth (vector-ref y8 1)) "飛") (begin (set! sum (- sum 300)) #f)))
      ((and (exist? 2 8) (eq? (fourth (vector-ref y8 2)) "飛") (begin (set! sum (+ sum 48)) #f)))
      ((and (exist? 8 7) (eq? (fourth (vector-ref y7 8)) "金") (begin (set! sum (- sum 40)) #f)))
      ((and (exist? 1 9) (eq? (fourth (vector-ref y9 1)) "香") (begin (set! sum (+ sum 10)) #f)))
      ((and (exist? 8 9) (eq? (fourth (vector-ref y9 8)) "桂") (begin (set! sum (+ sum 15)) #f)))
      (else sum))))

(define eval0
  (lambda (sum)
    (cond
      ((and (exist? 4 3) (eq? (fourth (vector-ref y3 4)) "歩") (begin (set! sum (+ sum 30)) #f)))
      ((and (exist? 2 2) (eq? (fourth (vector-ref y2 2)) "銀") (begin (set! sum (+ sum 20)) #f)))
      ((and (exist? 2 2) (eq? (fourth (vector-ref y2 2)) "角") (begin (set! sum (- sum 8)) #f)))
      ((and (exist? 3 2) (eq? (fourth (vector-ref y2 3)) "金") (begin (set! sum (+ sum 52)) #f)))
      ((and (exist? 5 2) (eq? (fourth (vector-ref y2 5)) "金") (begin (set! sum (+ sum 10)) #f)))
      ((and (exist? 6 2) (eq? (fourth (vector-ref y2 6)) "銀") (begin (set! sum (+ sum 9)) #f)))
      ((and (exist? 4 1) (eq? (fourth (vector-ref y1 4)) "王") (begin (set! sum (+ sum 6)) #f)))
      ((and (exist? 3 1) (eq? (fourth (vector-ref y1 3)) "王") (begin (set! sum (+ sum 8)) #f)))
      ((and (exist? 2 2) (eq? (fourth (vector-ref y2 2)) "王") (begin (set! sum (+ sum 10)) #f)))
      ((and (exist? 8 4) (eq? (fourth (vector-ref y4 8)) "歩") (begin (set! sum (+ sum 12)) #f)))
      ((and (exist? 8 5) (eq? (fourth (vector-ref y5 8)) "歩") (begin (set! sum (+ sum 25)) #f)))
      ((and (exist? 6 4) (eq? (fourth (vector-ref y4 6)) "歩") (begin (set! sum (+ sum 3)) #f)))
      ((and (exist? 6 3) (eq? (fourth (vector-ref y3 6)) "銀") (begin (set! sum (+ sum 10)) #f)))
      ((and (exist? 5 4) (eq? (fourth (vector-ref y4 5)) "銀") (begin (set! sum (+ sum 12)) #f)))
      ((and (exist? 5 3) (eq? (fourth (vector-ref y3 5)) "歩") (begin (set! sum (+ sum 100)) #f)))
      ((and (exist? 4 3) (eq? (fourth (vector-ref y3 4)) "歩") (begin (set! sum (+ sum 30)) #f)))
      ((and (exist? 2 3) (eq? (fourth (vector-ref y3 2)) "歩") (begin (set! sum (+ sum 50)) #f)))
      ((and (exist? 8 6) (eq? (fourth (vector-ref y6 8)) "飛") (begin (set! sum (+ sum 90)) #f)))
      ((and (exist? 9 2) (eq? (fourth (vector-ref y2 9)) "飛") (begin (set! sum (- sum 300)) #f)))
      ((and (exist? 8 2) (eq? (fourth (vector-ref y2 8)) "飛") (begin (set! sum (+ sum 45)) #f)))
      ((and (exist? 2 3) (eq? (fourth (vector-ref y3 2)) "金") (begin (set! sum (- sum 40)) #f)))
      ((and (exist? 9 1) (eq? (fourth (vector-ref y1 9)) "香") (begin (set! sum (+ sum 10)) #f)))
      ((and (exist? 2 1) (eq? (fourth (vector-ref y1 2)) "桂") (begin (set! sum (+ sum 15)) #f)))
      (else sum))))


(define mppoint
  (lambda (k)
    (cond
      ((eq? k "王") 9000)
      ((eq? k "飛") 1280)        ;+80
      ((eq? k "角") 1050)        ;+150
      ((eq? k "金") 710)         ;+110
      ((eq? k "銀") 620)         ;+100
      ((eq? k "桂") 435)         ;+90
      ((eq? k "香") 400)         ;+90
      ((eq? k "歩") 50)          ;+30
      (else 0))))

(define ppoint
  (lambda (k nari)
    (cond
      ((eq? k "王") 9000)
      ((eq? k "飛")
       (if (= nari 1) 1500 1100)) ;+400
      ((eq? k "角")
       (if (= nari 1) 1200 900))  ;+300
      ((eq? k "金") 600)
      ((eq? k "銀")
       (if (= nari 1) 560 520))   ;+40
      ((eq? k "桂")
       (if (= nari 1) 435 345))   ;+90
      ((eq? k "香")
       (if (= nari 1) 400 310))   ;+90
      ((eq? k "歩")
       (if (= nari 1) 370 20))    ;+350
      (else 0))))

(define distance
  (lambda (x y ox oy)
    (+ (abs (* (- x ox) (- x ox))) (abs (* (- y oy) (- y oy))))))

(define eval-aux
  (lambda (x y k nari Ox Oy)
       (cond
         ((and (eq? k "飛") (= nari 0) (or (= x 1) (= x 9))) (- (ppoint k nari) 150))
         ((and (eq? k "飛") (= nari 1) (= y Oy))
          (cond
            ((= (distance x y Ox Oy) 4) (+ (ppoint k nari) 350))
            ((= (distance x y Ox Oy) 9) (+ (ppoint k nari) 180))
            ((= (distance x y Ox Oy) 16) (+ (ppoint k nari) 140))
            ((= (distance x y Ox Oy) 25) (+ (ppoint k nari) 100))
            (else (+ (ppoint k nari) 80))))
         ((and (eq? k "飛") (= nari 0) (or (= y 7) (= y 3))) (- (ppoint k nari) 200))
  
         ((and (eq? k "角") (= nari 1) (and (> y 3) (< y 7)) (and (< x 7) (> x 2))) (+ (ppoint k nari) 50))
         ((and (eq? k "金") (and (> y 2) (< y 8))) (- (ppoint k nari) 90))
         ((and (= nari 1) (eq? k "歩"))
          (cond
           ((< (distance x y Ox Oy) 4) (+ (ppoint k nari) 300))
           ((< (distance x y Ox Oy) 9) (+ (ppoint k nari) 200))
           ((< (distance x y Ox Oy) 14) (+ (ppoint k nari) 100))
           ((< (distance x y Ox Oy) 21) (- (ppoint k nari) 100))
           (else (- (ppoint k nari) 350))))
         ((= nari 1)
           (cond
           ((< (distance x y Ox Oy) 4) (+ (ppoint k nari) 300))
           ((< (distance x y Ox Oy) 9) (+ (ppoint k nari) 200))
           ((< (distance x y Ox Oy) 14) (+ (ppoint k nari) 100))
           ((< (distance x y Ox Oy) 21) (- (ppoint k nari) 50))
           (else (- (ppoint k nari) 90))))
         (else (ppoint k nari)))))

(define earlyeval
  (lambda (s sum)
      (for ([k (range 15)])
        (cond
         ((exist? k 0)
          (if (eq? (car (vector-ref y0 k)) s)
              (set! sum (+ sum (mppoint (fourth (vector-ref y0 k))) 0))    ;0にしてみる
              (set! sum (- sum (mppoint (fourth (vector-ref y0 k)))))))))
      (for ([i '(1 2 3 4 5 6 7 8 9)])
         (for ([j '(1 2 3 4 5 6 7 8 9)])
          (cond
           ((exist? j i)
             (if (eq? (car (vector-ref (yn i) j)) s)
                 (set! sum (+ sum (ppoint (fourth (vector-ref (yn i) j)) (fifth (vector-ref (yn i) j)))))
                 (set! sum (- sum (ppoint (fourth (vector-ref (yn i) j)) (fifth (vector-ref (yn i) j))))))))))
       sum))

(define eval
  (lambda (s sum s_oposi ss_oposi)
    (for ([k (range 35)])
        (cond
         ((exist? k 0)
          (if (eq? (car (vector-ref y0 k)) s)
              (set! sum (+ sum (mppoint (fourth (vector-ref y0 k))) 10))
              (set! sum (- sum (mppoint (fourth (vector-ref y0 k)))))))))
      (for ([i '(1 2 3 4 5 6 7 8 9)])
         (for ([j '(1 2 3 4 5 6 7 8 9)])
          (cond
           ((exist? j i)
             (if (eq? (car (vector-ref (yn i) j)) s)
                 (set! sum (+ sum (eval-aux j i (fourth (vector-ref (yn i) j))
                                            (fifth (vector-ref (yn i) j)) (cadr ss_oposi) (caddr ss_oposi))))
                 (set! sum (- sum (eval-aux j i (fourth (vector-ref (yn i) j))
                                            (fifth (vector-ref (yn i) j)) (cadr s_oposi) (caddr s_oposi)))))))))
    sum))
  
(define evaluate
  (lambda (s)
    (cond
      ((and (= part 1) (= s 1))
       (+ (eval1 0) (earlyeval 1 0)))
      ((and (= part 1) (= s 0))
       (+ (eval0 0) (earlyeval 0 0)))
      (else (eval s 0 (oposi s) (oposi (ss s)))))))


(define tumi_1te '())

(define 1tetumi?
  (lambda (s s_ote)
    (cond
      ((null? s_ote) #f)
      ((begin (1te (car s_ote)) #f))
      ((null? (escapeOte (ss s))) (begin (1teback) #t))
      (else (begin (1teback) (1tetumi? s (cdr s_ote)))))))

(define tumu?_esc
  (lambda (s lls X)
    (cond
      ((null? lls) #t)
      ((begin (1te (car lls)) #f))
      ((1tetumi? (ss s) (s_Ote (ss s))) (begin (1teback) (tumu?_esc s (cdr lls) X)))
      (else (begin (1teback) #f)))))

(define tumu?_ote
  (lambda (s lls X)
    (cond
      ((null? lls) #f)
      ((begin (set! X (car lls)) (1te (car lls)) #f))
      ((null? (escapeOte (ss s))) (begin (1teback) (set! tumi_1te X) #t))
      ((tumu?_esc (ss s) (escapeOte (ss s)) X) (begin (1teback) (set! tumi_1te X) #t))
      (else (begin (1teback) (tumu?_ote s (cdr lls) X))))))

(define tumu?
  (lambda (s)
    (cond
      ((or (Ote? s) (Ote? (ss s))) (begin (set! tumi_1te '()) #f))
      ((tumu?_ote s (s_Ote s) '()) #t)
      (else  (begin (set! tumi_1te '()) #f)))))

(define escape_te '())

(define escapetumi?-aux
 (lambda (s lls)
   (cond
     ((null? lls) (not (null? escape_te)))
     ((begin (1te (car lls)) #f))
     ((and (not (Ote? (ss s))) (not (tumu? (ss s))))
      (begin (1teback) (set! escape_te (cons (car lls) escape_te)) (escapetumi?-aux s (cdr lls))))
     (else (begin (1teback) (escapetumi?-aux s (cdr lls)))))))

(define escapetumi?
  (lambda (s)
    (cond
      ((begin (set! escape_te '()) #f)) 
      ((= s 1) (escapetumi?-aux s (append (s_xy_m s '(4 5 6 7 8 9) '(1 2 3 4 5 6 7 8 9))
                                          (append (s_xy_p s (yrange_defense s (caddr (oposi s)))
                                                                   (xrange_defense s (cadr (oposi s))))
                                             (s_hika_mp s '() '())))))
      ((= s 0) (escapetumi?-aux s (append (s_xy_m s '(1 2 3 4 5 6) '(1 2 3 4 5 6 7 8 9))
                                          (append (s_xy_p s (yrange_defense s (caddr (oposi s)))
                                                                   (xrange_defense s (cadr (oposi s))))
                                             (s_hika_mp s '() '()))))))))

(define put_when_attack
  (lambda (s ls l)
    (for ([k (range 35)])
      (cond
        ((and (exist? k 0) (eq? (car (vector-ref y0 k)) s)
              (not (or (eq? (fourth (vector-ref y0 k)) "角") (eq? (fourth (vector-ref y0 k)) "飛")))
               (not (member (fourth (vector-ref y0 k)) ls)))
            (cond
              ((= s 1)
               (begin (set! l (append (xy_canput (vector-ref y0 k)
                                                     '(3 4 5) '(2 3 4 5)) l))
                          (set! ls (cons (fourth (vector-ref y0 k)) ls))))
              ((= s 0)
               (begin (set! l (append (xy_canput (vector-ref y0 k)
                                                     '(5 6 7) '(5 6 7 8)) l))
                          (set! ls (cons (fourth (vector-ref y0 k)) ls))))))
        (else #f))) l))

(define put_when_defense
  (lambda (s ls l)
    (for ([k (range 35)])
      (cond
        ((and (exist? k 0) (eq? (car (vector-ref y0 k)) s)
              (not (or (eq? (fourth (vector-ref y0 k)) "角") (eq? (fourth (vector-ref y0 k)) "飛")))
               (not (member (fourth (vector-ref y0 k)) ls)))
            (cond
              ((= s 1)
               (begin (set! l (append (xy_canput (vector-ref y0 k)
                                               '(6 7 8 9) '(2 3 4 5 6 7 8)) l))
                          (set! ls (cons (fourth (vector-ref y0 k)) ls))))
              ((= s 0)
               (begin (set! l (append (xy_canput (vector-ref y0 k)
                                               '(1 2 3 4) '(2 3 4 5 6 7 8)) l))
                          (set! ls (cons (fourth (vector-ref y0 k)) ls))))))
        (else #f))) l))

(define s_Ote-aux
  (lambda (s lls l)
    (cond
      ((null? lls) l)
      ((begin (1te (car lls)) #f))
      ((Ote? s) (begin (1teback) (s_Ote-aux s (cdr lls) (cons (car lls) l))))
      (else (begin (1teback) (s_Ote-aux s (cdr lls) l))))))

(define s_Ote
  (lambda (s)
    (s_Ote-aux s (reverse (s_mp s)) '())))


(define cut_outside
  (lambda (ls)
    (cond
      ((null? ls) '())
      ((or (< 9 (car ls)) (< (car ls) 1)) (cut_outside (cdr ls)))
      (else (cons (car ls) (cut_outside (cdr ls)))))))

(define xrange_defense
  (lambda (s x)
    (cut_outside (list (- x 2) (- x 1) x (+ x 1) (+ x 2)))))

(define xrange_attack
  (lambda (s x)
    (cut_outside (list (- x 4)(- x 3) (- x 2) (- x 1) x (+ x 1) (+ x 2) (+ x 3) (+ x 4)))))

(define yrange_defense
  (lambda (s y)
    (cond
      ((= s 1) (cut_outside (list (- y 2) (- y 1) y (+ y 1))))
      ((= s 0) (cut_outside (list (- y 1) y (+ y 1) (+ y 2)))))))

(define yrange_attack
  (lambda (s y)
    (cond
      ((= s 1) (cut_outside (list (- y 1) y (+ y 1) (+ y 2) (+ y 3) (+ y 4))))
      ((= s 0) (cut_outside (list (- y 4) (- y 3) (- y 2) (- y 1) y (+ y 1)))))))


(define init-aux
  (lambda (lls)
    (cond
    ((null? lls) #t)
    (else (begin (vector-set! (yn (third (car lls))) (second (car lls)) (car lls)) (init-aux (cdr lls)))))))
(define init
  (lambda ()
    (init-aux (list
'(0 5 1 "王" 0)
'(0 4 1 "金" 0)
'(0 6 1 "金" 0)
'(0 3 1 "銀" 0)
'(0 7 1 "銀" 0)
'(0 2 1 "桂" 0)
'(0 8 1 "桂" 0)
'(0 1 1 "香" 0)
'(0 9 1 "香" 0)
'(0 8 2 "飛" 0)
'(0 2 2 "角" 0)
'(0 1 3 "歩" 0)
'(0 2 3 "歩" 0)
'(0 3 3 "歩" 0)
'(0 4 3 "歩" 0)
'(0 5 3 "歩" 0)
'(0 6 3 "歩" 0)
'(0 7 3 "歩" 0)
'(0 8 3 "歩" 0)
'(0 9 3 "歩" 0)
'(1 5 9 "王" 0)
'(1 4 9 "金" 0)
'(1 6 9 "金" 0)
'(1 3 9 "銀" 0)
'(1 7 9 "銀" 0)
'(1 2 9 "桂" 0)
'(1 8 9 "桂" 0)
'(1 1 9 "香" 0)
'(1 9 9 "香" 0)
'(1 2 8 "飛" 0)
'(1 8 8 "角" 0)
'(1 1 7 "歩" 0)
'(1 2 7 "歩" 0)
'(1 3 7 "歩" 0)
'(1 4 7 "歩" 0)
'(1 5 7 "歩" 0)
'(1 6 7 "歩" 0)
'(1 7 7 "歩" 0)
'(1 8 7 "歩" 0)
'(1 9 7 "歩" 0)
))))


(init)
(display "AIside 1or0")
(define AIside (read))
(match)
