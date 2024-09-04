extends Control

signal splash_screen_ended

var sfx_options := ["sfx_do", "sfx_re", "sfx_mi", "sfx_fa", "sfx_sol", "sfx_la", "sfx_si"]


func _ready():
	%Container.position = get_viewport_rect().size/2


func run() -> void:
	var a_sound: AudioStreamPlayer = AudioPlayer.play_sound(sfx_options[randi_range(0, 6)])
	await get_tree().create_timer(1).timeout
	AudioPlayer.fade_out(a_sound, 5)


func end():
	emit_signal("splash_screen_ended")
	self.queue_free()


func _on_zap_pressed():
	end()


func _on_animation_player_animation_finished(anim_name):
	end()
