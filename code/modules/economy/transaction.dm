/**
 * Transaction datum for economy accounts
 */
/datum/bank_transaction
	/// type
	var/type = TRANSACTION_GENERIC
	/// initiator/device name that made the transaction
	var/initiator_name = "UNKNOWN"
	/// amount - from perspective of destination aka 100 for transferred 100 from src to dest - MUST BE NUMBER
	var/amount
	/// add'l info/reason
	var/desc = "Balance transfer."

/datum/bank_transaction/New(type, initiator, amount, desc)
	if(type)
		src.type = type
	if(inititaor)
		src.inititaor = initiator
	if(amount)
		src.amount = amount
	if(desc)
		src.desc = replacetext(desc, "%AMOUNT%", render_currency(amount))
