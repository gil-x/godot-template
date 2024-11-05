extends StaticBody2D

@onready var collision_shape: CollisionShape2D = %CollisionShape2D

var tween : Tween


func _ready() -> void:
	var duration_scale = randi_range(5, 10) / 10.0
	var duration_modulate = randi_range(1, 20) / 10.0
	self.scale = Vector2(0.0, 0.0)
	self.modulate = Color.TRANSPARENT
	tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), duration_scale)
	tween.tween_property(self, "modulate", Color.WHITE, duration_modulate)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func explode():
	collision_shape.disabled = true
	tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.10)
	tween.tween_property(self, "modulate", Color.WHITE, 0.10)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.05)
	tween.tween_property(self, "modulate", Color.WHITE, 0.05)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.15)
	tween.tween_callback(queue_free)
