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

    This above code defines the public function 'num', which determines if a given integer is even or odd. If the number is even, it adds to the odd-even counter and returns "The number is even"; otherwise, it returns "The number is odd" without changing the counter.

* Private Function
    
     This type of function can be called by current contract only. They cannot be accessed by other contract or directly by other transactions because private functions combine repetitive logic into reusable helper functions, they are very helpful for streamlining code. For example, we can abstract a condition which occurs multiple times in contract into a private function like, verifying contract caller identity. 
     
     Furthermore, big public functions become less complicated when private functions are used. The contract may be easier to maintain and less prone to mistakes if they are divided into smaller, modular private functions. Any data type, including responses, can be returned by private functions; but, unless specifically included in a public function, returning values such as 'ok' or 'err' won't change the status of the blockchain.

     For example:

        (define-constant C-owner tx-sender)

        (define-constant invalid-caller (err u1))

        (define-map principal recipients  uint)

        (define-private (is-valid-caller)
            (is-eq C-owner C-caller)    
        )

        (define-public (add-recipient (recipient principal)(amount uint))
            (if (is-valid-caller)
                (ok (map-set recipients recipient amount))
                invalid-caller    
            )    
        )

        (define-public (delete-recipient (recipient principal))
            (if (is-valid-caller)
                (ok (map-delete  recipients recipient))
                invalid-caller
            )
            
        )

        ;; Two example calls to the public functions:
        (print (add-recipient 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK u500))
        (print (delete-recipient 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK))

    The contract in the above example permits only the owner to change the recipients map using the add-recipient and delete-recipient public services. The is-valid-caller private function encapsulates the logic for determining whether the caller is the contract owner, avoiding duplication. The recipients list can only be updated by the contract owner thanks to this secret feature.

* Read-Only Function

    This type of function can be invoked externally but cannot alter the blockchain state and donot requires a transaction. These functions are primarily used to retrieve information, and it can return any datatype like private function. 

    Read-only functions can only do read operations, as their name implies. You are not allowed to change variables or maps, but you can access them. Additionally, read-only functions can be completely functional, which means they don't need to interact with contract state variables to execute calculations and produce a result.

     For example, adding two numbers and returning the result is allowed:

        (define-read-only (add (a uint) (b uint))
	     (+ a b)
        )

        (print (add u5 u10))

    We can read data from the contract state, such as a counter variable:

        (define-data-var counter uint u0)

        (define-read-only (get-counter-value)
            (var-get counter)
        )

        (print (get-counter-value))

    Nevertheless, write operations cannot be carried out by read-only functions. The contract will fail analysis and be declared illegal if you try to change the state inside a read-only function, like trying to increase a counter: 

        (define-data-var counter uint u0)

        (define-read-only (increment-counter)
            (var-set (+ (var-get counter) u1))
        )

        (print (increment-counter))

    The Clarity language ensures that this type of mistake is detected at the analysis stage, preventing deployment of invalid contracts.

    The ability to invoke read-only functions without sending a transaction is one of their main advantages; users can read data from the contract without having to pay transaction fees. Developers can rapidly access contract state by using built-in support for invoking read-only methods included in platforms such as Stacks.js and the Web Wallet Extension.

    For example, we can create a read-only function that retrieves a counter value associated with a given principal, or returns u0 if the principal doesn't exist in the map:

        (define-map counters principal uint)

        (map-set counters 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK u5)
        (map-set counters 'ST20ATRN26N9P05V2F1RHFRV24X8C8M3W54E427B2 u10)

        (define-read-only (get-counter-of (who principal))
            ;; Implement.
        )

        ;; These exist:
        (print (get-counter-of 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK))
        (print (get-counter-of 'ST20ATRN26N9P05V2F1RHFRV24X8C8M3W54E427B2))

        ;; This one does not:
        (print (get-counter-of 'ST21HMSJATHZ888PD0S0SSTWP4J61TCRJYEVQ0STB))



