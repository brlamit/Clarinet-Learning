Functions

Function are segments of code which accepts input and produce output. They are used to separate program code into logical components. In clarity, there are mainly built-in functions. But in clarity, it focuses on custom functions specially public functions, private functions, and read-only functions.



* Public Function

    This type of function can be called externally by another contract or principal and require sending a transaction, which incurs fees. 

* Private Function 

    This type of function can be called by current contract only. It cannot be called externally.

* Read-only Function

    This type of function can be invoked externally but cannot alter the blockchain state and donot requires a transaction.

Syntax of function: 

    (define-public function-signature function-body)

The function signature is used to specifies the function name and input parameters, while the function body contains the expression(s) executed when the function is called. 

Example-1: The below function 'show' doesnot take any parameters.

    (define-public (show)
        (ok, " Clearity is easy ")
    )
    (print (hello-world))

Examplw-2: The below function 'sum' take two parameters.

    (define-public (sum (x uint) (y uint))
        (ok(+ x y))    
    )
    (print (sum u34 u120))

Functions can have multiple expressions using the begin function, which allows you to chain several expressions together, returning the result of the last one:

    (define-public (print-num (first (uint)) (second (uint)))
        (begin
            (print first)
            (print second)
            (ok true)
        )
    )
    (print-num u7 u87)


