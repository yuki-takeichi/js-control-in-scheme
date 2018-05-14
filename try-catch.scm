(use gauche.partcont)

(define (main)
  (try-catch-example #t #t)
  (try-catch-example #f #t)
  (try-catch-example-2 #t #t)
  (try-catch-example-2 #f #t)
  )

(define (try-catch-example arg1 arg2)
  (define (exception-handler arg)
    (print "thrown: " arg))

  (print "try-catch-example")
  (reset (if arg1 
             (print "not thrown1")
             (shift k (exception-handler "thrown1")))
         (if arg2
             (print "not thrown2")
             (shift k (exception-handler "thrown2")))
         )
  (print "end"))

;; XXX debug
;; XXX add finally
(define-syntax try
  (syntax-rules (catch)
    ((_ expr ... (catch e handler))
     (reset
       (let ((exception-handler (lambda (e) handler)))
         expr ...)))))

(define-syntax throw
  (syntax-rules ()
    ((_ arg ...) (shift k (exception-handler arg ...)))))

(define (try-catch-example-2 arg1 arg2)
  (print "try-catch-example-2")
  (try
    (if arg1
        (print "not thrown1")
        (throw "thrown1"))
    (if arg1
        (print "not thrown2")
        (throw "thrown2"))
    (catch e (print "thrown: " e))
    )
  (print "end")
  )

(main)
