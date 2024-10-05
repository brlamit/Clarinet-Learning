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

3.Composites 
