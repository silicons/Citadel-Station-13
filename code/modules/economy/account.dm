/**
 * Represents an economy account
 */
/datum/bank_account
	/// account number - this is practically its UID. Always should be unique, do not let players change this
	var/id
	/// account holder name
	var/owner
	/// balance
	var/balance = 0
	/// transaction log
	var/list/datum/bank_transaction/transaction_log = list()
	/// locked security mode
	var/security_mode_locked = FALSE
	/// security mode
	var/security_mode = ACCOUNT_SECURITY_NONE
	/// PIN
	var/passkey
	/// faction this belongs to - this determines if, say, NT accounts managers can fuck with it
	var/faction = /datum/world_faction/nanotrasen
	/// linked bank card components
	var/list/datum/component/bank_card/linked_cards = list()

/datum/bank_account/proc/GetName()
	return "Account #[id]"

/datum/bank_account/proc/CreateTransactionLog(type, initiator, amount, desc)
	transaction_log += new /datum/bank_transaction(type, initiator, amount, desc)

/datum/bank_account/proc/Transfer(datum/bank_account/other, type = TRANSACTION_TRANSFER, initiator = "Unknown", amount, desc = "%AMOUNT% transferred from [GetName()] to [other.GetName()]")
	if(amount < 0)
		return FALSE
	if(amount > balance)
		return FALSE
	other.balance += amount
	balance -= amount
	CreateTransactionLog(type, initiator, amount, desc)

/datum/bank_account/proc/Deposit(datum/bank_account/other, type = TRANSACTION_DEPOSIT, initiator = "Unknown", amount, desc = "%AMOUNT% deposited.")
	if(amount < 0)
		return FALSE
	balance += amount
	CreateTransactionLog(type, initiator, amount, desc)

/datum/bank_account/proc/Withdraw(datum/bank_account/other, type = TRANSACTION_WITHDRAW, initiator = "Unknown", amount, desc = "%AMOUNT% withdrawn.")
	if(amount < 0)
		return FALSE
	balance -= amount
	CreateTransactionLog(type, initiator, amount, desc)

/datum/bank_account/proc/MakeBankCard(obj/item/I, component_type = /datum/component/bank_card)
	ASSERT(isptah(component_type, /datum/component/bank_card))
	linked_cards += I.AddComponent(component_type)

/datum/bank_account/proc/RemoveBankCard(obj/item/I)
	#warn sigh how do we do this with components or do i just go back to id cards jesus christ


/datum/bank_account/proc/RemoveCardComponent(datum/component/bank_card)
	if(bank_card.account == src)
		bank_card.account = null
	linked_cards -= bank_card
