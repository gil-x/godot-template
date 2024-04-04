extends Control

@export var level0 : PackedScene


func _ready():
	$VBoxContainer/StartButton.grab_focus()


func _on_start_button_pressed():
	print("Start called")
	var level = level0.instantiate()
	get_node("/root/Main").call_deferred("add_sibling", level)
	call_deferred("queue_free")
	Game.change_state(Game.State.IN_GAME)
	#Game.current_state = change_state(Game.State.IN_GAME)


func _on_options_button_pressed():
	Debug.print("Options called")


func _on_quit_button_pressed():
	get_tree().quit()
