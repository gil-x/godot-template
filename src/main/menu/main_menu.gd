extends Control

@export var level0: PackedScene
var tween: Tween


func _ready():
	self.modulate = 0
	$VBoxContainer/StartButton.grab_focus()
	%Music.play()
	tween = create_tween().set_parallel(true)
	tween.tween_property(%Music, "volume_db", -15, 3.0)
	tween.tween_property(self, "modulate", Color.WHITE, 2.0)


func fadeOutMusic(duration: float) -> bool:
	tween = create_tween().set_parallel(true)
	tween.tween_property(%Music, "volume_db", -80, duration)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, duration)
	await get_tree().create_timer(1).timeout
	return true


func _on_start_button_pressed():
	print("Start called")
	var level = level0.instantiate()
	if await fadeOutMusic(1.0):
		get_node("/root/Main").call_deferred("add_sibling", level)
		call_deferred("queue_free")
		Game.change_state(Game.State.IN_GAME)


func _on_options_button_pressed():
	Debug.print("Options called")


func _on_quit_button_pressed():
	if await fadeOutMusic(1.0):
		get_tree().quit()
