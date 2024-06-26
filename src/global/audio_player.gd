extends Node

var tween : Tween

# Naming convention is mandatory!
var sounds = {
	"sfx_bound": preload("res://assets/samples/tone1.mp3"),
	"sfx_cannon": preload("res://assets/samples/cannon_fire.ogg"),
	"music_menu": preload("res://assets/samples/Which_brand_of_mustard_shall_i_buy.ogg"),
	"music_ingame": preload("res://assets/samples/technogeek.mp3")
}
var sfx_bound = preload("res://assets/samples/tone1.mp3")
var music_menu = preload("res://assets/samples/Which_brand_of_mustard_shall_i_buy.ogg")
var music_ingame = preload("res://assets/samples/technogeek.mp3")


func _free_audioplayer(asp: AudioStreamPlayer):
	await asp.finished
	asp.queue_free()
	

func fade_out(asp: AudioStreamPlayer, duration: float):
	tween = create_tween().set_parallel(true)
	tween.tween_property(asp, "volume_db", -100, duration)
	asp.seek(asp.stream.get_length() * 0.9)
	

func play_sound(sound_name: String) -> AudioStreamPlayer:
	var asp = AudioStreamPlayer.new()
	if sounds.has(sound_name):
		asp.stream = sounds[sound_name]
	else:
		push_error("No sound named '%s' found." % sound_name)
	
	# Name node is option for debug purpose	
	if "sfx" in sound_name:
		asp.bus = "Music"
		asp.name = "SFX_%s" % asp.get_instance_id()
	elif "music" in sound_name:
		asp.bus = "SFX"
		asp.name = "MUSIC_%s" % asp.get_instance_id()
	
	add_child(asp)
	asp.play()
	_free_audioplayer(asp)
	
	return asp
