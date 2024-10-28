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

* ## asserts!

The asserts! function is an useful control flow in clarity which allows to evaluate boolean expressions and either returns an error or permits the function to continue execution. It takes two parameters i.e boolean expression and throw value. This function executes if the boolean expression becomes true, else it return the throw value allowing to stop execution.

Syntax

    (asserts! boolean-expression throw-value)

Example

    (asserts! true (err "failed"))  ;; Passes, continues execution
    (asserts! false (err "failed")) ;; Fails, returns error

An assertion "short-circuits" the function when it fails, returning the given error and ignoring any additional expressions. This is assertive! helpful for establishing guards to ensure specific conditions hold before advancing with function logic.