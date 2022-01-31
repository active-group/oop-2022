;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "beginner-reader.rkt" "deinprogramm" "sdp")((modname fp-intro-2) (read-case-sensitive #f) (teachpacks ()) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ())))
; Animals on the Texas highway is one of the following:
; - armadillo - OR -
; - parrot
; case analysis, NOT enumeration, full data definition for each case
; here: mixed data
(define animal
  (signature (mixed dillo parrot)))

; Armadillo has the following properties: <- compound data
; - alive or dead
; - weight
(define-record dillo
  make-dillo
  dillo? ; predicate
  (dillo-alive? boolean)
  (dillo-weight number))
; representation of the state of an armadillo *at a certain time*

(: make-dillo (boolean number -> dillo))
(: dillo-alive? (dillo -> boolean))
(: dillo-weight (dillo -> number))

(: dillo? (any -> boolean))

; live armadillo, weighs 10kg
(define dillo1 (make-dillo #t 10))
; dead armadillo, 8kg
(define dillo2 (make-dillo #f 8))

#|
class Dillo {
  boolean isAlive;
  double weight;

  void runOver() {
    this.isAlive = false;
  }
}
|#

; run over an armadillo
(: run-over-dillo (dillo -> dillo))

(check-expect (run-over-dillo dillo1)
              (make-dillo #f 10))
(check-expect (run-over-dillo dillo2)
              dillo2)

; template
#;(define run-over-dillo
  (lambda (dillo)
    (make-dillo ... ...)
    ... (dillo-alive? dillo) ... (dillo-weight dillo) ...))


(define run-over-dillo
  (lambda (dillo)
    (make-dillo #f (dillo-weight dillo))))

; feed an armadillo, live armadillos gain weight, dead ones don't
(: feed-dillo (dillo number -> dillo))

(check-expect (feed-dillo dillo1 5)
              (make-dillo #t 15))
(check-expect (feed-dillo dillo2 5)
              dillo2)

(define feed-dillo
  (lambda (dillo amount)
    (make-dillo (dillo-alive? dillo)
                (cond
                  ((dillo-alive? dillo)
                   (+ (dillo-weight dillo) amount)) ; live 
                  (else (dillo-weight dillo)))))) ; dead


; A parrot has the following properties:
; - sentence
; - weight
(define-record parrot
  make-parrot
  parrot?
  (parrot-sentence string)
  (parrot-weight number))

(define parrot1 (make-parrot "Hello!" 1))
(define parrot2 (make-parrot "Goodbye!" 2))

; run over an parrot
(: run-over-parrot (parrot -> parrot))

(check-expect (run-over-parrot parrot1)
              (make-parrot "" 1))

(define run-over-parrot
  (lambda (parrot)
    (make-parrot "" (parrot-weight parrot))))


; run over an animal
(: run-over-animal (animal -> animal))

(check-expect (run-over-animal dillo1)
              (run-over-dillo dillo1))
(check-expect (run-over-animal parrot1)
              (run-over-parrot parrot1))

; template
#;(define run-over-animal
  (lambda (animal)
    (cond
      ((dillo? animal) ...)
      ((parrot? animal) ...))))


(define run-over-animal
  (lambda (animal)
    (cond
      ((dillo? animal) (run-over-dillo animal))
      ((parrot? animal) (run-over-parrot animal)))))

; FP: more cases in mixed data => function definitions change
; OOP: more cases in mixed data => just add class

; FP: more operations => just add functions
; OOP: change interface and all classes

; "expression problem": make both cheap

#|
interface Animal {
   Animal runOver();
   Animal feed(double amount); <--
}

class Dillo implements Animal {
  @Override Animal runOver() { ... }
}

class Parrot implements Animal {
  @Override Animal runOver() { ... }
}

class Rattlesnake implements Animal {
...
}
|#

; "finite sequences" / "lists"

; "list" in FP: specific data structure

; A list is one of the following:
; - empty list
; - a cons list, consisting of first element and rest list
;                                                     ^^^^ self-reference

; self-reference: key to creating flexible data structure, flexible domain models
(define list-of-numbers
  (signature (mixed empty-list
                    cons-list)))

; A empty list ...
(define-record empty-list
  make-empty
  empty?)

(define empty (make-empty))

; A cons list consists of:
; - first element
; - rest list
(define-record cons-list
  cons
  cons?
  (first number)
  (rest list-of-numbers))

; 1-element list: 7
(define list1 (cons 7 empty))
; 2-element list: 7 5
(define list2 (cons 7 (cons 5 empty)))
; 3-element list: 7 3 9
(define list3 (cons 7 (cons 3 (cons 9 empty))))
; 4-element list: 5 7 3 9
(define list4 (cons 5 list3))

; add all the numbers in a list
(: list-sum (list-of-numbers -> number))

(check-expect (list-sum list4)
              24)

(define list-sum
  (lambda (list)
    (cond
      ((empty? list) 0) ; neutral element / identity -> algebra
      ((cons? list)
       (+ (first list)
          (list-sum (rest list)))))))

; multiply all the numbers in a list
(: list-product (list-of-numbers -> number))

(check-expect (list-product list3)
              189)

(define list-product
  (lambda (list)
    (cond
      ((empty? list) 1)
      ((cons? list)
       (* (first list)
          (list-product (rest list)))))))


(define list-fold
  (lambda (n op list)
    (cond
      ((empty? list) n)
      ((cons? list)
       (op (first list)
           (list-fold n op (rest list)))))))

