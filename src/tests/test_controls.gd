extends Control


func disable_arrow(arrow: Label) -> void:
	arrow.modulate = Color.WHITE


func disable_arrows() -> void:
	for arrow in %Panel.get_children():
		arrow.modulate = Color.WHITE


func highlight_arrow(arrow: Label) -> void:
	arrow.modulate = Color.YELLOW_GREEN


func _process(delta):
	# Detect key press
	if Input.is_action_pressed("ui_up"):
		highlight_arrow(%Up)
	if Input.is_action_pressed("ui_down"):
		highlight_arrow(%Down)
	if Input.is_action_pressed("ui_left"):
		highlight_arrow(%Left)
	if Input.is_action_pressed("ui_right"):
		highlight_arrow(%Right)
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left"):
		highlight_arrow(%UpLeft)
		disable_arrow(%Up)
		disable_arrow(%Left)
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right"):
		highlight_arrow(%UpRight)
		disable_arrow(%Up)
		disable_arrow(%Right)
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left"):
		highlight_arrow(%DownLeft)
		disable_arrow(%Down)
		disable_arrow(%Left)
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right"):
		highlight_arrow(%DownRight)
		disable_arrow(%Down)
		disable_arrow(%Right)
	# Detect release
	if Input.is_action_just_released("ui_up"):
		Debug.print("ui_up released")
		disable_arrows()
	if Input.is_action_just_released("ui_down"):
		Debug.print("ui_down released")
		disable_arrows()
	if Input.is_action_just_released("ui_left"):
		Debug.print("ui_left released")
		disable_arrows()
	if Input.is_action_just_released("ui_right"):
		Debug.print("ui_right released")
		disable_arrows()
