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
	/// date
	var/date
	/// timestamp
	var/time
	/// uid - used by game to sort
	var/uid
	var/static/uid_next = 0

/datum/bank_transaction/New(type, initiator, amount, desc, date, time)
	if(type)
		src.type = type
	if(inititaor)
		src.inititaor = initiator
	if(amount)
		src.amount = amount
	if(desc)
		src.desc = replacetext(desc, "%AMOUNT%", render_currency(amount))
	if(date)
		src.date = date
	if(time)
		src.time = time
	Timestamp()
	uid = ++uid_next

/datum/bank_transaction/proc/Timestamp()
	#warn impl - station time and date
	if(!date)

	if(!time)
		time = STATION_TIME_TIMESTAMP
