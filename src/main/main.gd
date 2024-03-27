extends Node

func debug_test():
	var empty = null
	Debug.print(empty)
	Debug.print(8)
	Debug.print("Hey, I am a string logged from main.")
	Debug.print([Vars.hello_global, "other", 99])


func _ready():
	debug_test()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
