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

; live armadillo, weighs 10kg
(define dillo1 (make-dillo #t 10))
; dead armadillo, 8kg
(define dillo2 (make-dillo #f 8))


