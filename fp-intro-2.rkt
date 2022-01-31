;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "beginner-reader.rkt" "deinprogramm" "sdp")((modname fp-intro-2) (read-case-sensitive #f) (teachpacks ()) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ())))
; Animals on the Texas highway

; Armadillo has the following properties: <- compound data
; - alive or dead
; - weight
(define-record dillo
  make-dillo
  (dillo-alive? boolean)
  (dillo-weight number))
; representation of the state of an armadillo *at a certain time*

(: make-dillo (boolean number -> dillo))
(: dillo-alive? (dillo -> boolean))
(: dillo-weight (dillo -> number))

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


