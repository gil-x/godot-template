extends Control

var current_button : Button

@onready var left_button : Button = %ButtonUILeft
@onready var left_label : Label = %LabelLeft
@onready var right_button : Button = %ButtonUIRight
@onready var right_label : Label = %LabelRight
@export var test_controls : PackedScene


func _ready() -> void:
	left_button.pressed.connect(_on_button_pressed.bind(left_button))
	right_button.pressed.connect(_on_button_pressed.bind(right_button))
	%ButtonTest.pressed.connect(_on_button_pressed.bind(%ButtonTest))
	%ExitTest.pressed.connect(_on_button_pressed.bind(%ExitTest))
	_update_labels()
	%InfoPanel.hide()
	hide_test_panel()


func show_test_panel():
	%TestCanvas.show()


func hide_test_panel():
	%TestCanvas.hide()


func _on_button_pressed(button: Button) -> void:
	if button.name == "ButtonTest":
		show_test_panel()
	elif button.name == "ExitTest":
		hide_test_panel()
	else:
		current_button = button
		%InfoPanel.show()


func assign_key(action : String, key : InputEvent) -> void:
	InputMap.action_add_event(current_button.get_meta("command"), key)


func test_remove_key_from_ui_right():
	var keys_assigned : Array[InputEvent] = InputMap.action_get_events("ui_right")
	Debug.print(keys_assigned)
	InputMap.action_erase_event("ui_right", keys_assigned[0])
	Debug.print(keys_assigned)
	_update_labels()


func read_dict(dict_keys):
	for k in dict_keys:
		Debug.print([k, dict_keys[k]])


func _input(event: InputEvent) -> void:
	if !current_button:
		return
	if event is InputEventKey || event is InputEventMouseButton:
		var all_actions : Dictionary = {}
		for action in InputMap.get_actions():
			all_actions[action] = InputMap.action_get_events(action)

		for action in all_actions:
			if action != current_button.get_meta("command"):
				for event_key in InputMap.action_get_events(action):
					Debug.print(event_key)
					if event_key.as_text() == event.as_text():
						InputMap.action_erase_event(action, event_key)

		assign_key(current_button.get_meta("command"), event)

		current_button = null
		%InfoPanel.hide()
		_update_labels()


func list_assigned_keys(command_name : String, as_bullets : bool = false) -> String:
	var keys_assigned : Array[InputEvent] = InputMap.action_get_events(command_name)
	if !keys_assigned.is_empty():
		var keys = []
		if as_bullets:
			for key in keys_assigned:
				keys.append("- " + key.as_text())
			return "\n".join(keys)
		else:
			for key in keys_assigned:
				keys.append(key.as_text())
			return " | ".join(keys)
	return ""
	
	
func _update_labels() -> void:
	left_label.text = list_assigned_keys("ui_left", true)
	right_label.text = list_assigned_keys("ui_right", true)
