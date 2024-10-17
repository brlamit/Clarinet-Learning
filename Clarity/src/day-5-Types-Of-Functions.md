* Public Function

    This type of function can be called externally by another contract or principal and require sending a transaction, which incurs fees. But the functionality within these functions are not fully exposed. We can add conditions, ensuring that only authorized user or valid input can trigger the desired actions.

    In public function, it must return a response type value. A function returns 'ok' when the transaction is valid, and any modifications to the blockchain, such as state updates or token transfers, are recorded. If the function returns an 'err', the modifications are reversed, indicating that the function call had no effect on the state.

    For example, consider a function that determine whether a number is odd or even. The function modifies a variable before calculating the number. If the number is even, the method returns 'OK' otherwise, it returns 'Error'. If an error is returned, the variable update is reversed, as if the function had never been run. This rollback mechanism ensures that only successful operations can change the blockchain.

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

    This above code defines the public function 'num', which determines if a given integer is even or odd. 
    If the number is even, it adds to the odd-even counter and returns "The number is even"; otherwise, 
    it returns "The number is odd" without changing the counter.

