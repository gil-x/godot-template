extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(Game.MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(Game.MUSIC_BUS_ID, value < .05)
	

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(Game.SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(Game.SFX_BUS_ID, value < .05)
