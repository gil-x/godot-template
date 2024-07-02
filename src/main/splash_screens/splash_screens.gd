extends Control

signal all_splash_screens_ended

var splash_screens = []


func display_screen():
	var screen = splash_screens.pop_front()
	screen.splash_screen_ended.connect(self._on_splash_screen_ended)
	%Screens.call_deferred("add_child", screen)


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
