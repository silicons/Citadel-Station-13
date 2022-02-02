
/datum/money_account
	var/owner_name = ""
	var/account_number = 0
	var/remote_access_pin = 0
	var/money = 0
	var/list/transaction_log = list()
	var/suspended = 0
	var/security_level = 0	//0 - auto-identify from worn ID, require only account number
							//1 - require manual login / account number and pin
							//2 - require card and manual login

/datum/transaction
	var/target_name = ""
	var/purpose = ""
	var/amount = 0
	var/date = ""
	var/time = ""
	var/source_terminal = ""

/proc/create_account(var/new_owner_name = "Default user", var/starting_funds = 0, var/obj/machinery/account_database/source_db)

	//create a new account
	var/datum/money_account/M = new()
	M.owner_name = new_owner_name
	M.remote_access_pin = rand(1111, 111111)
	M.money = starting_funds

	//create an entry in the account transaction log for when it was created
	var/datum/transaction/T = new()
	T.target_name = new_owner_name
	T.purpose = "Account creation"
	T.amount = starting_funds
	if(!source_db)
		//set a random date, time and location some time over the past few decades
		T.date = "[num2text(rand(1,31))] [pick("January","February","March","April","May","June","July","August","September","October","November","December")], 25[rand(10,56)]"
		T.time = "[rand(0,24)]:[rand(11,59)]"
		T.source_terminal = "NTGalaxyNet Terminal #[rand(111,1111)]"

		M.account_number = rand(111111, 999999)
	else
		T.date = current_date_string
		T.time = stationtime2text()
		T.source_terminal = source_db.machine_id

		M.account_number = next_account_number
		next_account_number += rand(1,25)

		//create a sealed package containing the account details
		var/obj/item/smallDelivery/P = new /obj/item/smallDelivery(source_db.loc)

		var/obj/item/paper/R = new /obj/item/paper(P)
		P.wrapped = R
		R.name = "Account information: [M.owner_name]"
		R.info = "<b>Account details (confidential)</b><br><hr><br>"
		R.info += "<i>Account holder:</i> [M.owner_name]<br>"
		R.info += "<i>Account number:</i> [M.account_number]<br>"
		R.info += "<i>Account pin:</i> [M.remote_access_pin]<br>"
		R.info += "<i>Starting balance:</i> $[M.money]<br>"
		R.info += "<i>Date and time:</i> [stationtime2text()], [current_date_string]<br><br>"
		R.info += "<i>Creation terminal ID:</i> [source_db.machine_id]<br>"
		R.info += "<i>Authorised NT officer overseeing creation:</i> [source_db.held_card.registered_name]<br>"

		//stamp the paper
		var/image/stampoverlay = image('icons/obj/bureaucracy.dmi')
		stampoverlay.icon_state = "paper_stamp-cent"
		if(!R.stamped)
			R.stamped = new
		R.stamped += /obj/item/stamp
		R.overlays += stampoverlay
		R.stamps += "<HR><i>This paper has been stamped by the Accounts Database.</i>"

	//add the account
	M.transaction_log.Add(T)
	all_money_accounts.Add(M)

	return M

/proc/charge_to_account(var/attempt_account_number, var/source_name, var/purpose, var/terminal_id, var/amount)
	for(var/datum/money_account/D in all_money_accounts)
		if(D.account_number == attempt_account_number && !D.suspended)
			D.money += amount

			//create a transaction log entry
			var/datum/transaction/T = new()
			T.target_name = source_name
			T.purpose = purpose
			if(amount < 0)
				T.amount = "([amount])"
			else
				T.amount = "[amount]"
			T.date = current_date_string
			T.time = stationtime2text()
			T.source_terminal = terminal_id
			D.transaction_log.Add(T)

			return 1

	return 0

//this returns the first account datum that matches the supplied accnum/pin combination, it returns null if the combination did not match any account
/proc/attempt_account_access(var/attempt_account_number, var/attempt_pin_number, var/security_level_passed = 0)
	for(var/datum/money_account/D in all_money_accounts)
		if(D.account_number == attempt_account_number)
			if( D.security_level <= security_level_passed && (!D.security_level || D.remote_access_pin == attempt_pin_number) )
				return D
			break

/proc/get_account(var/account_number)
	for(var/datum/money_account/D in all_money_accounts)
		if(D.account_number == account_number)
			return D


#define RIOTS 1
#define WILD_ANIMAL_ATTACK 2
#define INDUSTRIAL_ACCIDENT 3
#define BIOHAZARD_OUTBREAK 4
#define WARSHIPS_ARRIVE 5
#define PIRATES 6
#define CORPORATE_ATTACK 7
#define ALIEN_RAIDERS 8
#define AI_LIBERATION 9
#define MOURNING 10
#define CULT_CELL_REVEALED 11
#define SECURITY_BREACH 12
#define ANIMAL_RIGHTS_RAID 13
#define FESTIVAL 14

#define RESEARCH_BREAKTHROUGH 15
#define BARGAINS 16
#define SONG_DEBUT 17
#define MOVIE_RELEASE 18
#define BIG_GAME_HUNTERS 19
#define ELECTION 20
#define GOSSIP 21
#define TOURISM 22
#define CELEBRITY_DEATH 23
#define RESIGNATION 24

#define DEFAULT 1

#define ADMINISTRATIVE 2
#define CLOTHING 3
#define SECURITY 4
#define SPECIAL_SECURITY 5

#define FOOD 6
#define ANIMALS 7

#define MINERALS 8

#define EMERGENCY 9
#define GAS 10
#define MAINTENANCE 11
#define ELECTRICAL 12
#define ROBOTICS 13
#define BIOMEDICAL 14

#define GEAR_EVA 15


//---- The following corporations are friendly with NanoTrasen and loosely enable trade and travel:
//Corporation NanoTrasen - Generalised / high tech research and phoron exploitation.
//Corporation Vessel Contracting - Ship and station construction, materials research.
//Corporation Osiris Atmospherics - Atmospherics machinery construction and chemical research.
//Corporation Second Red Cross Society - 26th century Red Cross reborn as a dominating economic force in biomedical science (research and materials).
//Corporation Blue Industries - High tech and high energy research, in particular into the mysteries of bluespace manipulation and power generation.
//Corporation Kusanagi Robotics - Founded by robotics legend Kaito Kusanagi in the 2070s, they have been on the forefront of mechanical augmentation and robotics development ever since.
//Corporation Free traders - Not so much a corporation as a loose coalition of spacers, Free Traders are a roving band of smugglers, traders and fringe elements following a rigid (if informal) code of loyalty and honour. Mistrusted by most corporations, they are tolerated because of their uncanny ability to smell out a profit.

//---- Descriptions of destination types
//Space stations can be purpose built for a number of different things, but generally require regular shipments of essential supplies.
//Corvettes are small, fast warships generally assigned to border patrol or chasing down smugglers.
//Battleships are large, heavy cruisers designed for slugging it out with other heavies or razing planets.
//Yachts are fast civilian craft, often used for pleasure or smuggling.
//Destroyers are medium sized vessels, often used for escorting larger ships but able to go toe-to-toe with them if need be.
//Frigates are medium sized vessels, often used for escorting larger ships. They will rapidly find themselves outclassed if forced to face heavy warships head on.

var/global/current_date_string

var/global/datum/money_account/vendor_account
var/global/datum/money_account/station_account
var/global/list/datum/money_account/department_accounts = list()
var/global/num_financial_terminals = 1
var/global/next_account_number = 0
var/global/list/all_money_accounts = list()
var/global/list/transaction_devices = list()
var/global/economy_init = 0

/proc/setup_economy()
	if(economy_init)
		return 2

	//news_network.CreateFeedChannel("The [GLOB.using_map.starsys_name] Times", "[GLOB.using_map.starsys_name] Times ExoNode - [GLOB.using_map.station_short]", 1, 1)
	news_network.CreateFeedChannel("The Gibson Gazette", "Editor Mike Hammers", 1, 1)
	news_network.CreateFeedChannel("Oculum Content Aggregator", "Oculus v6rev7", 1, 1)

	for(var/loc_type in typesof(/datum/trade_destination) - /datum/trade_destination)
		var/datum/trade_destination/D = new loc_type
		weighted_randomevent_locations[D] = D.viable_random_events.len
		weighted_mundaneevent_locations[D] = D.viable_mundane_events.len

	create_station_account()

	for(var/department in station_departments)
		create_department_account(department)
	create_department_account("Vendor")
	vendor_account = department_accounts["Vendor"]

	for(var/obj/item/retail_scanner/RS in transaction_devices)
		if(RS.account_to_connect)
			RS.linked_account = department_accounts[RS.account_to_connect]
	for(var/obj/machinery/cash_register/CR in transaction_devices)
		if(CR.account_to_connect)
			CR.linked_account = department_accounts[CR.account_to_connect]

	current_date_string = "[num2text(rand(1,31))] [pick("January","February","March","April","May","June","July","August","September","October","November","December")], [game_year]"

	economy_init = 1
	return 1

/proc/create_station_account()
	if(!station_account)
		next_account_number = rand(111111, 999999)

		station_account = new()
		station_account.owner_name = "[station_name()] Station Account"
		station_account.account_number = rand(111111, 999999)
		station_account.remote_access_pin = rand(1111, 111111)
		station_account.money = 75000

		//create an entry in the account transaction log for when it was created
		var/datum/transaction/T = new()
		T.target_name = station_account.owner_name
		T.purpose = "Account creation"
		T.amount = 75000
		T.date = "2nd April, 2555"
		T.time = "11:24"
		T.source_terminal = "Biesel GalaxyNet Terminal #277"

		//add the account
		station_account.transaction_log.Add(T)
		all_money_accounts.Add(station_account)

/proc/create_department_account(department)
	next_account_number = rand(111111, 999999)

	var/datum/money_account/department_account = new()
	department_account.owner_name = "[department] Account"
	department_account.account_number = rand(111111, 999999)
	department_account.remote_access_pin = rand(1111, 111111)
	department_account.money = 5000

	//create an entry in the account transaction log for when it was created
	var/datum/transaction/T = new()
	T.target_name = department_account.owner_name
	T.purpose = "Account creation"
	T.amount = department_account.money
	T.date = "2nd April, 2555"
	T.time = "11:24"
	T.source_terminal = "Biesel GalaxyNet Terminal #277"

	//add the account
	department_account.transaction_log.Add(T)
	all_money_accounts.Add(department_account)

	department_accounts[department] = department_account
