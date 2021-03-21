extends StaticBody2D

class_name Wall

export var player_wall_offset = 10

var paddle_spawned = false

func set_paddle(paddle: Node2D) -> void:
	paddle.transform = transform
	var center_dir = (_get_viewport_center() - transform.origin).normalized()
	paddle.transform.origin += center_dir * player_wall_offset
	paddle_spawned = true

func _get_viewport_center() -> Vector2:
	var rect = get_viewport_rect().size
	return rect / 2
