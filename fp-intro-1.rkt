;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "beginner-reader.rkt" "deinprogramm" "sdp")((modname fp-intro-1) (read-case-sensitive #f) (teachpacks ((lib "image.rkt" "teachpack" "deinprogramm" "sdp"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image.rkt" "teachpack" "deinprogramm" "sdp")))))
; Language -> Choose Language -> "Schreibe Dein Programm - Anfänger" (NOT: "Beginner")
; If you don't see image.rkt:
; Go to Language -> Add Teachpack -> image.rkt -> OK
(define x
  (+ 12
     (* 23
        42)))
; x stands for 978

; names stand for values
; circle1 stands for a circle
(define circle1 (circle 50 "solid" "red"))
(define star1 (star 50 "solid" "green"))
(define square1 (square 100 "outline" "blue"))
(define overlay1 (overlay star1 circle1))

#;(above
 (beside circle1 star1)
 (beside star1 circle1))

#;(above
 (beside square1 circle1)
 (beside circle1 square1))

; design recipes / Konstruktionsanleitung

; short description
; create a square tile pattern from two images

; signature declaration
(: tile (image image -> image))

; test
(check-expect (tile star1 square1)
              (above
               (beside star1 square1)
               (beside square1 star1)))


(define tile
  (lambda (image1 image2)
    (above
     (beside image1 image2)
     (beside image2 image1))))

;(tile 5 7)

;(tile star1 square1)

#|
class C {
  static int m(int x) {
    // x does not stand for a number!
    // x stands for a memory cell, which contains a number
    ... 27 ...
    x = x + 1;
    ... 27 ...
  }

  C.m(27) ... could we replace x by 27 in the body of m?
}

|#

; Data analysis
; A pet is one of the following:
; - dog - OR - ... represented by "dog"
; - cat - OR -
; - snake 
; ^^^^ case analysis / itemization
; special case: enumeration
(define pet
  (signature (enum "dog" "cat" "snake")))

; Is a pet cute?
; "isCute"
(: cute? (pet -> boolean))

(check-expect (cute? "dog") #t)
(check-expect (cute? "cat") #t)
(check-expect (cute? "snake") #f)

; skeleton
#;(define cute?
  (lambda (pet)
    ...))

; template
#;(define cute?
  (lambda (pet)
    (cond ; branch, 3 cases
      ; each branch: (<condition> <result>)
      ((string=? pet "dog") ...)
      ((string=? pet "cat") ...)
      ((string=? pet "snake") ...))))

(define cute?
  (lambda (pet)
    (cond ; branch, 3 cases
      ; each branch: (<condition> <result>)
      ((string=? pet "dog") #t)
      ((string=? pet "cat") #t)
      ((string=? pet "snake") #f))))

; Time consists of / has the following properties:
; - hour - AND -
; - minute
; compound data
(define hour (signature (integer-from-to 0 23)))
(define minute (signature (integer-from-to 0 59)))

(define-record time
  make-time ; constructor
  (time-hour hour) ; "getter function", "selector"
  (time-minute minute))

(: make-time (hour minute -> time))
(: time-hour (time -> hour))
(: time-minute (time -> minute))

; 12:24
(define time1 (make-time 12 24))
; 14:27
(define time2 (make-time 14 27))

; How many minutes since midnight?
(: msm (time -> natural))

(check-expect (msm time1)
              744)

; template
#;(define msm
  (lambda (time)
    ... (time-hour time) ... (time-minute time) ...))

(define msm
  (lambda (time)
    (+ (* 60 (time-hour time))
       (time-minute time))))

; write a function that takes minutes since midnight and produces a time record