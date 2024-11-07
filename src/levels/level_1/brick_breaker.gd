extends Node

@onready var bricks: Node = %Bricks
@onready var ball: RigidBody2D = %Ball
@onready var lifes: FlowContainer = %Lifes
@onready var shader: Sprite2D = %Shader
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var color_rect: ColorRect = %ColorRect
@onready var bricks_count: Label = %BricksCount
@onready var end_game_popup: CenterContainer = %EndGamePopup
@onready var label_victory: Label = %LabelVictory
@onready var label_loss: Label = %LabelLoss

@export_range(0, 10) var lives = 3
@export_range(1, 10) var bricks_line = 3
@export_range(0, 10) var empty_space = 3
@export var brick_scene : PackedScene

var tween : Tween


func _ready() -> void:
	end_game_popup.hide()
	print(DisplayServer.screen_get_size())
	_reset_scene()
	

func _generate_bricks() -> void:
	var x_pos : int
	var y_pos := 64
	for l in bricks_line:
		x_pos = 32 + 32 * empty_space
		for c in range(24 - 2 * empty_space):
			var b = brick_scene.instantiate()
			b.position.x = x_pos
			b.position.y = y_pos
			bricks.call_deferred("add_child", b)
			b.connect("destroyed", _count_bricks)
			x_pos += 32
		y_pos += 24	


func _count_bricks() -> int:
	var bricks_amount := len(get_tree().get_nodes_in_group("bricks"))
	bricks_count.text = str(bricks_amount)
	return bricks_amount


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
	#Debug.print(get_tree().current_scene.name)
	if ball:
		Debug.print([ball.position.x, ball.position.y])
		if ball.position.y > DisplayServer.window_get_size().y:
			_ball_lost()
	if _count_bricks() == 0:
		end_game_popup.show()
		label_victory.show()
		animation_player.play("victory")
		ball.set_physics_process(false)


func _ball_lost() -> void:
	var lives = lifes.get_children()
	if len(lives) == 0:
		var gameover_sound: AudioStreamPlayer = AudioPlayer.play_sound("sfx_gameover")
		set_process(false)
		animation_player.play("game_over")
		await get_tree().create_timer(3).timeout
		end_game_popup.show()
		label_loss.show()
		_count_bricks()
	else:
		var lost_ball_sound: AudioStreamPlayer = AudioPlayer.play_sound("sfx_fall")
		ball.position.y = 200.0
		lives.pop_back().queue_free()
		animation_player.play("glitch")


func _reset_scene() -> void:
	end_game_popup.hide()
	label_victory.hide()
	label_loss.hide()
	# replace ball
	ball.set_physics_process(false)
	# remove all bricks
	if len(get_tree().get_nodes_in_group("bricks")) > 0:
		for b in get_tree().get_nodes_in_group("bricks"):
			b.queue_free()
	_generate_bricks()
	_create_lives()
	animation_player.play("start_game")
	bricks_count.text = str(bricks_line * (24 - empty_space * 2))
	await get_tree().create_timer(2).timeout
	ball.set_physics_process(true)
	ball.position.x = 392.0
	ball.position.y = 200.0
	set_process(true)
	

func _on_button_quit_pressed() -> void:
	get_tree().quit()
