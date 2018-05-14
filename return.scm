(use gauche.partcont)

(define (main)
  (print (return-example #t))
  (print (return-example #f))
  (print (return-example-2 #t))
  (print (return-example-2 #f))
  (print "end"))

(define (return-example arg)
  (reset (print "return-example")
         (if arg (shift k "true")
                 (print "fuga"))
         "false"))

(define-syntax define-with-return
  (syntax-rules ()
    ((_ args body ...) (define args (reset body ...)))))

(define-syntax return
  (syntax-rules ()
    ((_ expr) (shift k expr))))

(define-with-return (return-example-2 arg)
  (print "return-example-2")
  (if arg (return "true")
          (print "fuga"))
  "false")

(main)
