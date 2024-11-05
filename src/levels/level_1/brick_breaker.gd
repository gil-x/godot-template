extends Node

@onready var bricks: Node = %Bricks
@onready var ball: RigidBody2D = %Ball
@onready var lifes: FlowContainer = %Lifes
@onready var shader: Sprite2D = %Shader
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var color_rect: ColorRect = %ColorRect

@export_range(0, 5) var lives = 3
@export_range(1, 5) var bricks_line = 3
@export var brick_scene : PackedScene

var tween : Tween


func _ready() -> void:
	ball.set_physics_process(false)
	animation_player.play("start_game")
	await get_tree().create_timer(2).timeout
	ball.set_physics_process(true)
	print(DisplayServer.screen_get_size())
	_generate_bricks()
	_create_lives()


func _generate_bricks() -> void:
	var x_pos : int
	var y_pos := 64
	for l in bricks_line:
		x_pos = 32
		for c in range(24):
			var b = brick_scene.instantiate()
			b.position.x = x_pos
			b.position.y = y_pos
			bricks.call_deferred("add_child", b)
			x_pos += 32
		y_pos += 24	
	
	
func _create_lives() -> void:
	var delay := 0.1

	for live in lives:
		var life := Label.new()
		life.text = "♥"
		life.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		life.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		life.set("theme_override_font_sizes/font_size", 24)
		life.modulate = Color.TRANSPARENT
		lifes.add_child(life)
		tween = create_tween()
		tween = create_tween()
		tween.tween_property(life, "modulate", Color.TRANSPARENT, delay)
		tween.tween_property(life, "modulate", Color.WHITE, delay)
		delay *= 2.0


func _process(delta: float) -> void:
	if ball:
		if ball.position.y > DisplayServer.window_get_size().y:
			ball_lost()


func ball_lost() -> void:
	var lives = lifes.get_children()
	if len(lives) == 0:
		var gameover_sound: AudioStreamPlayer = AudioPlayer.play_sound("sfx_gameover")
		set_process(false)
		animation_player.play("game_over")
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()
	else:
		var lost_ball_sound: AudioStreamPlayer = AudioPlayer.play_sound("sfx_fall")
		ball.position.y = 200.0
		lives.pop_back().queue_free()
		animation_player.play("glitch")
