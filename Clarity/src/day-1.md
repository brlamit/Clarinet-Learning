What is clarity?

Clarinet is a command-line tool that includes a Clarity runtime, aimed at simplifying the development, testing, and deployment of Clarity smart contracts. It features a Clarity REPL and a testing framework, enabling developers to quickly build and test their contracts without requiring deployment to a devnet or testnet.


Clarity itself is a smart contract language built for the Stacks blockchain, designed with a focus on predictability and security. It allows developers to encode critical business logic directly on the blockchain, ensuring a clear and reliable execution of contracts.


    (+ 4 5)

Types of Clarinet:

1.Primitives 

This types are the most basic components. It can be signed or unsigned integers, booleans and principals.
    
* Signed Integers:

    This types of integers are 128 bit numbers which can be positive or negative. The range of signed 
    integer is from -2^127 to 2^127 - 1. 

        Example:
        23, -114, 4545,....

* Unsigned Integers:

    This types of integers are 128 bit numbers which can only be positive numbers. The range of unsigned 
    integer is from 0 to 2^128 - 1. These integers are always prefixed by the characeter 'u'.

        Example:
        u2, u2423423,.....

* Booleans:

    This types of integers can either be true or fslse. It is used to check that if certain conditions are met or not.Some built in functions which accept booleans are:

    not (inverts a boolean):

        (not true)

    and (returns true if all inputs are true):

        (and true true true)

    or (returns true if at least one input is true):

        (or false true false)

* Principals:

    In Clarity, a principal represents a Stacks address on the blockchain and serves as a unique identifier, similar to how an email address or bank account number functions—though it's tailored for blockchain use. It's often referred to as a wallet address. Principals follow a specific structure, always starting with SP for Stacks mainnet addresses, and ST for addresses on the testnet and mocknet. Principals can be categorized into two types:

    * Standard Principals: These are linked to a private key, representing a regular user or wallet address.

    * Contract Principals: These refer to smart contracts on the blockchain.

2.Sequences 

This type holds a sequence of data. Clarity mostly provide three kinds of sequences : buffers, strings, and lists.

* Buffers

    They are unstructures data having fixed maximum length. It always starts with the prefix 0x followed by hexadecimal strings. 

        0x68656c6c6f20776f726c64
    The above buffer spells 'hello world'

* Strings:

    A string in Clarity is a sequence of characters, defined as either ASCII strings or UTF-8 strings. ASCII strings are limited to basic Latin characters, while UTF-8 strings can include more diverse characters, such as emoji. Both types of strings are enclosed in double quotes ("), but UTF-8 strings are distinguished by a u prefix. Like buffers, strings have a fixed maximum length in Clarity.

    ASCII:

        "This is an ASCII string"

    UTF-8:

        u"And this is an UTF-8 string \u{1f601}"

* Lists:

    Lists in Clarity are fixed-length sequences that hold elements of the same type. Since Clarity doesn't allow mixed types in a list, all items must be of a uniform type. For example, a list of signed integers would look like this:

        (list 4 8 15 16 23 42)
    Similarly, a list of ASCII strings would be:

        (list "Hello" "World" "!")
    However, mixing different types, such as integers and strings, is not allowed, and would result in an invalid list:

        (list u5 10 "hello") ;; This list is invalid.

    Lists are particularly useful for handling bulk actions, such as sending tokens to multiple recipients. You can iterate over lists using functions like map or fold.

3.Composites 

These are more complex types that contain a number of other types. Composites make it a lot easier to create larger smart contracts.

* Optionals:

    In Clarity, every value must always be defined—booleans are either true or false, and integers always have a number. However, when you need to express a variable that could have a value or nothing at all, you use the optional type. An optional wraps another type and can either contain none or a value of that type. For example:

    * Wrapping an unsigned integer:

            (some u5)

    * Wrapping an ASCII string:

            (some "An optional string.")
    
    * Wrapping a principal:

            (some 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE)

    If there is no value, it is represented by the keyword none. Functions that might or might not return a value often return an optional type. For instance, attempting to retrieve an element from a list at an invalid index might return none:

        (element-at (list 4 8 15 16 23 42) u5000)
        
    To access the value within an optional, you must unwrap it. Using unwrap-panic will return the value if it exists, but will throw an error if the value is none:

        (unwrap-panic (some u10)) ;; Returns u10
        (unwrap-panic none) ;; Throws an error

* Tuples:

    Tuples are records that store multiple values in named fields, each with its own type. This makes tuples ideal for passing structured data. Tuples are immutable, and once created, they cannot be changed. For example:

        {
            id: u5, 
            username: "ClarityIsAwesome", 
            address: 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JS8QE
        }

    You access tuple fields by name using the get function:

        (get username { id: 5, username: "ClarityIsAwesome" })

    Tuples can be merged, creating a new tuple by combining the fields. Conflicting fields are overwritten from left to right:

        (merge
            {id: 5, score: 10, username: "ClarityIsAwesome"}
            {score: 20, winner: true}
        )

    This results in a tuple where score is set to 20.

* Responses:

    Responses are another composite type similar to optionals, but they indicate whether an action was successful or failed. A response can be either (ok ...) or (err ...). For example:

        (ok true)  ;; Success response
        (err u5)   ;; Error response with a code

    Like optionals, responses can be unwrapped using unwrap-panic:

        (unwrap-panic (ok true))

    While typically used in public functions, private and read-only functions may also return response types.