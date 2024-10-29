(define-public (check-even (a (response uint uint)))
  (begin
    ;; Unwrap the response using `try!`
    (let (
      (num (try! a))  ;; Unwrap the number from the response
    )
      ;; Check if the number is even
      (if (is-eq (mod num u2) u0)
          (ok "The number is even.")  ;; Return if the number is even
          (ok "The number is odd.")   ;; Return if the number is odd
      )
    )
  )
)

;; Test cases
(print (check-even (ok u5)))  ;; Should return (ok "The number is odd.")
(print (check-even (ok u4)))  ;; Should return (ok "The number is even.")
(print (check-even (err u1))) ;; Should return (err u1)
