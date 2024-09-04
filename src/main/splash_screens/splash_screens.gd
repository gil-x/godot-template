extends Control

signal all_splash_screens_ended

var splash_screens = []
var wait_before_start : float = 1.0
const wait_between_screens : float = 1.0


func display_screen():
	await get_tree().create_timer(wait_before_start).timeout
	if wait_before_start != 0:
		wait_before_start = 0
	await get_tree().create_timer(wait_between_screens).timeout
	var screen = splash_screens.pop_front()
	screen.splash_screen_ended.connect(self._on_splash_screen_ended)
	%Screens.call_deferred("add_child", screen)
	screen.call_deferred("run")


func _ready():
	for child in %Screens.get_children():
		var clone = child.duplicate()
		splash_screens.append(clone)
		child.queue_free()
	display_screen()


func _on_splash_screen_ended():
	# Move to next splash screen
	if len(splash_screens) > 0:
		display_screen()
	else:
		emit_signal("all_splash_screens_ended")
