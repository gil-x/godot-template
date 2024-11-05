extends RigidBody2D


var signs := [-1, 1]
var sign : int
var init_speed : int
var velocity : Vector2

#Vector2(randi() % 500, randi() % 500)

#clamp(randi() % 200, -300, 300)


func _ready() -> void:
	sign = signs[randi() % signs.size()]
	init_speed = clamp(randi() % 300, 200, 300) 
	velocity = Vector2(
		clamp(init_speed, -300, 300) * sign,
		clamp(init_speed, 0, 300)
	)
	print(init_speed)
	
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var bound_sound: AudioStreamPlayer = AudioPlayer.play_sound("sfx_bound")
		velocity = velocity.bounce(collision.get_normal())
		velocity.x = clamp(velocity.x * 1.01, -5000, 5000)
		velocity.y = clamp(velocity.y * 1.01, -5000, 5000)
		var brick := collision.get_collider()
		if brick.has_method("explode"):
			brick.explode()
