extends Node

@export var splash_screens : PackedScene
@export var main_menu : PackedScene


func load_splash_screens():
	var splash_screens_scene = splash_screens.instantiate()
	splash_screens_scene.all_splash_screens_ended.connect(self._on_all_splash_screens_ended)
	call_deferred("add_child", splash_screens_scene)


func load_main_menu():
	var main_menu_scene = main_menu.instantiate()
	call_deferred("add_child", main_menu_scene)


func debug_test():
	var empty = null
	Debug.print(empty)
	Debug.print(8)
	Debug.print("Hey, I am a string logged from main.")
	Debug.print([Vars.hello_global, "other", 99])


func _ready():
	debug_test()
	load_splash_screens()
	Game.change_state(Game.State.SPLASH_SCREENS)
	%PauseCanvas.hide()


func _on_all_splash_screens_ended():
	Debug.print("All splash screens ended.")
	load_main_menu()
	Game.change_state(Game.State.TITLE_SCREEN)


func pause_game():
	if Game.current_state == Game.State.IN_GAME:
		Game.change_state(Game.State.PAUSED)
		%PauseCanvas.show()
	elif Game.current_state == Game.State.PAUSED:
		Game.change_state(Game.State.IN_GAME)
		%PauseCanvas.hide()


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
