extends Node

@export var splash_screens : PackedScene

func load_splash_screens():
	var splash_screens_scene = splash_screens.instantiate()
	splash_screens_scene.all_splash_screens_ended.connect(self._on_all_splash_screens_ended)
	call_deferred("add_child", splash_screens_scene)


func debug_test():
	var empty = null
	Debug.print(empty)
	Debug.print(8)
	Debug.print("Hey, I am a string logged from main.")
	Debug.print([Vars.hello_global, "other", 99])


func _ready():
	debug_test()
	load_splash_screens()

func _on_all_splash_screens_ended():
	Debug.print("All splash screens ended.")
