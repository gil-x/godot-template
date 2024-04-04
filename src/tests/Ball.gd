extends RigidBody2D

var velocity = Vector2(randi() % 500, randi() % 500)
@onready var velocity_display = %VelocityDisplay

func _physics_process(delta):
	velocity_display.text = str(velocity)
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		velocity.x = clamp(velocity.x * 1.1, -5000, 5000)
		velocity.y = clamp(velocity.y * 1.1, -5000, 5000)

