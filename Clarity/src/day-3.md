Storing Data

Smart contract have their own  private storage space which persists across transactions. We can define different data members that are accessible through the contract. These data members are stored on the blockchain, making it immutable after deployment.

Even though data members are private to the contract, they are not hidden from the public since the blockchain is inherently transparent. Therefore, storing sensitive information such as passwords or private keys in smart contract storage is not secure. Anyone can retrieve this data from the blockchain's state.

Mainly there are three types of storage in smart contract. 

* Constants

    These are unchangable value defined at the top of the contract. It is often used to store static values such as contract owner. The syntax to define a constant in Clarity is:

        (define-constant constant-name expression)

    Constants are evaluated at the time of contract deployment in the order they are defined. If one constant depends on another, they must be defined sequentially.

        (define-constant my-constant "This is a constant one")
        (define-constant my-second-constant (concat my-constant " that depends on constant two"))

    Constants can also be used to store the principal (the address) that deployed the contract:

        (define-constant contract-owner tx-sender)

    They are also useful for assigning names to error codes or return values, improving code clarity:

        (define-constant err-something (err u3400))


* Variables 

    These holds a value that can be updated through contract call. In this, each variables can store exactly one value of a predefined type. It is defined using following syntax:

        (define-data-var var-name var-type initial-value)

    where:
        * var-name: The name of the variable (avoid using reserved keywords).
        * var-type: A type signature specifying the variable's type.
        * initial-value: The starting value for the variable.

    For reading and modifying variables, Clarity provides the 'var-get' and 'var-set' functions.

    Example:

        ;; Define a variable of type uint with an initial value of u234.
        (define-data-var num uint u0234)

        ;; Print the initial value.
        (print (var-get num))

        ;; Change the value to u3544.
        (var-set num u3544)

        ;; Print the updated value.
        (print (var-get num))

    Type Signatures

    Each variable has a type signature that determines the kind of data it can hold. Here are common types:

      | Type              | Signature                                           |
      |-------------------|-----------------------------------------------------|
      | **Signed integer** | `int`                                              |
      | **Unsigned integer**| `uint`                                            |
      | **Boolean**        | `bool`                                             |
      | **Principal**      | `principal`                                        |
      | **Buffer**         | `(buff max-len)`, where `max-len` is the max length|
      | **ASCII string**   | `(string-ascii max-len)`, max length is `max-len`  |
      | **UTF-8 string**   | `(string-utf8 max-len)`, max length is `max-len`   |
      | **List**           | `(list max-len element-type)`                      |
      | **Optional**       | `(optional some-type)`                             |
      | **Tuple**          | `{key1: entry-type, key2: entry-type}`             |
      | **Response**       | `(response ok-type err-type)`                      |


    Variables are strictly limited by these types, and exceeding the maximum length for types like strings or buffers will result in errors.

    Here is an example of defining a more complex tuple variable:

        (define-data-var Score
        ;; Tuple type definition:
            {
                t-score: uint,
                who: (optional principal),
                at-height: uint
            }
            ;; Initial tuple value:
            {
                t-score: u45,
                who: none,
                at-height: u0
            }
        )

        ;; Print the initial value.
        (print (var-get Score))

        ;; Change the value.
        (var-set Score
            {t-score: u454, who: (some tx-sender), at-height: block-height}
        )

        ;; Print the new value.
        (print (var-get Score))

    This allows for dynamic changes to complex data structures within the contract, while still maintaining control over data types.


* Maps

    These are similar to variables but it allow us to associate one value with another. A map is defined using 'define-map':

        (define-map map-name key-type value-type)

    Both 'key-type' and 'value-type' can be any valid type signature, although tuples are normally used because of their versatility.

        ;; A map that creates a principal => uint relation.
        (define-map balances principal uint)

        ;; Set the "balance" of the tx-sender to u343.
        (map-set balances tx-sender u343)

        ;; Retrieve the balance.
        (print (map-get? balances tx-sender))
    
    We can also use map to store and read basic orders by ID.

        (define-map orders uint {maker: principal, amount: uint})

        ;;Set three orders.
        (map-set orders u0 {maker: tx-sender, amount: u45})
        (map-set orders u1 {maker: tx-sender, amount: u233})
        (map-set orders u2 {maker: tx-sender, amount: u355})

        ;; retriving order with ID u1.
        (print(map-get? orders u1))

    Maps are not iterable i.e we cannot loop through maps and retrive all values. We can only access value in a map by specifying the right key.

    There are two function in map:

    * map-set : This function is used to overwrite existing values.

    * map-insert : This function returns 'false' and do nothing, if the specified key already exists.

    * map-delete: This will delete entities.

    Example:

        (define-map scores principal uint)

        ;; Insert a value.
        (map-insert scores tx-sender u100)

        ;; This second insert will do nothing because the key already exists.
        (map-insert scores tx-sender u200)

        ;; The score for tx-sender will be u100.
        (print (map-get? scores tx-sender))

        ;; Delete the entry for tx-sender.
        (map-delete scores tx-sender)

        ;; Will return none because the entry got deleted.
        (print (map-get? scores tx-sender))

    

