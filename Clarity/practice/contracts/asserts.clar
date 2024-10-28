(define-constant contract-owner tx-sender)

;; Try removing the contract-owner constant above and using a different
;; one to see the example calls error out:
;; (define-constant contract-owner 'ST20ATRN26N9P05V2F1RHFRV24X8C8M3W54E427B2)

(define-constant err-invalid-caller (err u1))

(define-map recipients principal uint)

(define-private (is-valid-caller)
	(is-eq contract-owner contract-caller)
)

(define-public (add-recipient (recipient principal) (amount uint))
	(begin
		;; Assert the contract-caller is valid.
		(asserts! (is-valid-caller) err-invalid-caller)
		(ok (map-set recipients recipient amount))
	)
)

(define-public (delete-recipient (recipient principal))
	(begin
		;; Assert the contract-caller is valid.
		(asserts! (is-valid-caller) err-invalid-caller)
		(ok (map-delete recipients recipient))
	)
)

;; ;; Two example calls to the public functions:
;; (print (add-recipient 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK u500))
;; (print (delete-recipient 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK))