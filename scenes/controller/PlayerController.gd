extends PaddleController

onready var input := $PlayerInput


func _unhandled_input(event):
	if input.handle_input(event):
		get_tree().set_input_as_handled()

func get_motion(paddle: Paddle) -> Vector2:
	return Vector2(
		input.get_action_strength("move_left") - input.get_action_strength("move_right"),
		input.get_action_strength("move_down") - input.get_action_strength("move_up")
	)
