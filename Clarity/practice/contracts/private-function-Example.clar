(define-constant C-owner 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK) ;; Example owner principal

(define-constant invalid-caller (err u1))

(define-map recipients principal uint)

;; Function to check if the caller is the contract owner
(define-private (is-valid-caller)
    (is-eq tx-sender C-owner)
)

;; Public function to add a recipient with an associated amount
(define-public (add-recipient (recipient principal) (amount uint))
    (if (is-valid-caller)
        (ok (map-set recipients recipient amount))
        invalid-caller
    )    
)

;; Public function to delete a recipient from the map
(define-public (delete-recipient (recipient principal))
    (if (is-valid-caller)
        (ok (map-delete recipients recipient))
        invalid-caller
    )
)

;; Example calls to the public functions:
;; Add a recipient
(print (add-recipient 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK u500))

;; Delete the recipient
(print (delete-recipient 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK))
