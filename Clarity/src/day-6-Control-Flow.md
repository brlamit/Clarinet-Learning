## Control Flow 

In Clarity, control flow describes the sequence in which expressions are assessed when a contract is being executed. Understanding control flow is crucial because it affects how smart contracts handle and react to various scenarios, particularly when handling failures. 

As contracts become more sophisticated, they can improve code readability and structure by terminating the function execution early if a specific condition is met.

In Clarity, expressions are evaluated in a straightforward left-to-right order. For example, the begin block evaluates its expressions sequentially:

    (begin
        (print "Hello One")
        (print "Hello Two")
        (print "Hello Three")
    )

In the above code 'Hello One' is executed first, then 'Hello Two' and lastly 'Hello Three'.

Similarly, we use 'If' expressions to return either 'ok' or 'err' response. 

    (if (is-eq (mod num u2) u0)
        (ok "Num is even")
        (err "Num is odd")
    )


Error Handling

Clarity provides special control flow functions that influence the execution of smart contracts and handle errors. Some of them are:

* try!
* asserts!
* unwrap!
* unwrap-err!
* unwrap-panic
* unwrap-err-panic

 ## asserts!

The asserts! function is an useful control flow in clarity which allows to evaluate boolean expressions and either returns an error or permits the function to continue execution. It takes two parameters i.e boolean expression and throw value. This function executes if the boolean expression becomes true, else it return the throw value allowing to stop execution.

Syntax:

    (asserts! boolean-expression throw-value)

Example:

    (asserts! true (err "failed"))  ;; Passes, continues execution
    (asserts! false (err "failed")) ;; Fails, returns error

An assertion "short-circuits" the function when it fails, returning the given error and ignoring any additional expressions. This is assertive! helpful for establishing guards to ensure specific conditions hold before advancing with function logic.

# try!

The try! function in Clarity is used to unwrap values from optional or response types. If the value is some or ok, it extracts and returns the inner value. However, if the value is none or err, it returns that value and exits the current control flow.

Syntax:

    (try! expression)

Example:

    (define-public (try-example (input (response uint uint)))
    (begin
        (try! input)
        (ok "end of the function")
    )
    )

    (print (try-example (ok u1)))   ;; Returns: (ok "end of the function")
    (print (try-example (err u2)))  ;; Returns: (err u2)

* When the input is (ok u1), try! successfully unwraps the ok value and proceeds to return
  (ok "end of  the function").
* When the input is (err u2), try! immediately exits, returning the original (err u2).

To summary, try! Error handling is simplified by permitting the propagation of err and none values, which allows for seamless control flow when unwrapping ok or some values.

