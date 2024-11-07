extends RigidBody2D


var signs := [-1, 1]
var sign : int
var init_speed : int
var velocity : Vector2

@export_range(0, 1000) var speed_variance = 300
#@export_range(0, 1000) var speed_max = 300

func _ready() -> void:
	sign = signs[randi() % signs.size()]
	init_speed = clamp(randi() % speed_variance, speed_variance / 2, speed_variance) 
	velocity = Vector2(
		clamp(init_speed, -speed_variance, speed_variance) * sign,
		clamp(init_speed, 0, speed_variance)
	)
	print(init_speed)
	
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		AudioPlayer.play_sound("sfx_bound")
		velocity = velocity.bounce(collision.get_normal())
		velocity.x = clamp(velocity.x * 1.01, -5000, 5000)
		velocity.y = clamp(velocity.y * 1.01, -5000, 5000)
		var brick := collision.get_collider()
		if brick.has_method("explode"):
			brick.explode()
