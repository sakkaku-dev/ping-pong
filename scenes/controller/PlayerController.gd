extends PaddleController

onready var input := $PlayerInput


func _unhandled_input(event):
	if input.handle_input(event):
		get_tree().set_input_as_handled()

func get_motion() -> Vector2:
	return Vector2(0, input.get_action_strength("move_down") - input.get_action_strength("move_up"))
