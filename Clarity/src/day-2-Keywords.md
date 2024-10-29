# Keywords

Keywords are the special terms which has a meaning. There are different types of keywords in clarity like : true , false, none, etc. Some other keywords are :

* ## Block-height

    This keyword reflect the current block height of the stack blockchain as an unsigned integer. 

        block-height

* ## Burn-block-height

    This keyword reflects the current block height of the underlying burn blockchain (in this case  Bitcoin) as an unsigned integer.

        burn-block-height

* ## tx-sender

    This keyword contains the principal (either a user or a contract) that sent the transaction. It is used to validate that who is making the call to a public function.

        tx-sender

    However, 'tx-sender' can be manipulated if a contract calls another contract. To avoid this we use 'contract-caller' keyword.

* ## contract-caller

    This keyword holds the principal that directly called the function. If the contract is called by another contract, contract-caller will reflect the previous contract in the call chain. 
    With this , permission checks will fail if a malicious contract attempts to access your contract, as the check will be against the malicious contract instead of the original caller.

        contract-caller


