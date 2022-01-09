// UI "options" list on rig_ui_options(). All of these have the static params "name", "id". Name is always displayed on the left, ID is what is sent ot ui_act.
// When something is called, rig_ui_act() is called with "option" = "type", "id" = "id". Type depends on the below, id is what you specified.
// Static params are sent on rig_ui_static_data().
// Params are sent on rig_ui_data().
// This is to minimize needing to send more data than necessary every update.
// Static params are only sent on static ui update or first load, and should have anything that isn't going to change more than once in a blue moon.
/**
 * Once again, the "Static Params" and "Params" are in additional to the above. ALL of these should have a name and ID!
 * Same for "calls rig_ui_act()". "option" and "id" will always be part of the params!
 *
 * Read code/modules/rigsuits/_component.dm for how to handle these. Do not attempt to handle this manually in rig_ui_act()! Not snowflaking this is crucial for hotbind functionality.
 */

/// Display text. Params: "text"
#define RIG_UI_OPTION_TEXT_DISPLAY			"text"
/// Display static text. Static params: "text"
#define RIG_UI_OPTION_STATIC_TEXT			"static_text"
/// List of named buttons. Static params: "button1", "button2", ... ; Params: None
#define RIG_UI_OPTION_BUTTON_LIST			"buttons"
/// List of named toggles. Static params: list("activetext", "inactivetext", "key"), ..., ... ; Params: list("key1", "key2", ...) = keys that are **on**
#define RIG_UI_OPTION_TOGGLE_LIST			"toggles"
/// Single button. Static params: "buttonname"
#define RIG_UI_OPTION_BUTTON				"button"
/// Single toggle. Static params: "activetext", "inactivetext", "key" ; Params: "on" = 0 or 1.
#define RIG_UI_OPTION_TOGGLE				"toggle"
/// Dropdown pick list. Static params: "option1", "option2", ... ; Params: "currentoptionname"
#define RIG_UI_OPTION_DROPDOWN_PICK			"dropdown"
/// Row list pick. Static params: "option1", "option2", ... ; Params: "currentoptionname"
#define RIG_UI_OPTION_LIST_PICK				"pick"
/// Number input. Static params: "min", "max", "step" optional ; Params: "value"
#define RIG_UI_OPTION_NUMBER_INPUT			"number"
/// Progress bar. Static params: "min", "max", "step" optional, "good" optional 0.0 to 1.0, "bad" optional 0.0 to 1.0 ; Params: "value"
#define RIG_UI_OPTION_PROGRESS_BAR			"prog"
/// Slider. Static params: "min", "max", "step" optional ; Params: "value"
#define RIG_UI_OPTION_SLIDER				"slider"
