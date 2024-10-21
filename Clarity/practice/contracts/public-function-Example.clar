 (define-data-var odd-even uint u0)

        (define-public (num (number uint))
            (begin
                ;; check if the input number is even.
                (if (is-eq (mod number u2) u0)
                    (begin
                        ;; increment the "odd-even" variable by one if the number is even.
                        (var-set odd-even (+ (var-get odd-even) u1))

                        (ok "The number is even")
                    )
                    ;; else block: return that the number is odd.

                    (ok "The number is odd")
                )
            )
        )

        (print (num u34))
        (print (num u67))