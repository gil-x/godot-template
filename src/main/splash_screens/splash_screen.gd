extends Control

signal splash_screen_ended


func _ready():
	%Container.position = get_viewport_rect().size/2


func end():
	emit_signal("splash_screen_ended")
	self.queue_free()


func _on_zap_pressed():
	end()


func _on_animation_player_animation_finished(anim_name):
	end()



