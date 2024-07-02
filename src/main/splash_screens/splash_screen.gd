extends Control

signal splash_screen_ended


func _ready():
	%Container.position = get_viewport_rect().size/2
	var a_sound: AudioStreamPlayer = AudioPlayer.play_sound("sfx_cannon")
	await get_tree().create_timer(1).timeout
	AudioPlayer.fade_out(a_sound, 5)


func end():
	emit_signal("splash_screen_ended")
	self.queue_free()


func _on_zap_pressed():
	end()


func _on_animation_player_animation_finished(anim_name):
	end()
