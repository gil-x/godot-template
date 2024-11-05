extends CharacterBody2D

const SPEED = 600.0


func _physics_process(delta: float) -> void:

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		#velocity.x = direction * SPEED
		velocity.x = lerp(velocity.x, direction * SPEED, 0.25)
	else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.x = lerp(velocity.x, direction * SPEED, 0.05)

	move_and_slide()
