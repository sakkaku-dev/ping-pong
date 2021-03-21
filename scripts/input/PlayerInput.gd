extends InputReader

"""
Input Reader for a single player
"""

class_name PlayerInput

export var joypad_input = false
export var device_id = 0


func set_for_event(event: InputEvent) -> void:
	device_id = event.device
	joypad_input = _is_joypad_event(event)


func is_player_event(event: InputEvent) -> bool:
	return joypad_input == _is_joypad_event(event) and device_id == event.device


func _is_joypad_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion


func handle_input(event: InputEvent) -> bool:
	if not is_player_event(event):
		return false
	
	return .handle_input(event)
