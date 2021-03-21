extends StaticBody2D

class_name Wall

export var player_wall_offset = 10

onready var sprite = $Sprite

var paddle_spawned = false setget ,get_paddle_spawned

func get_paddle_spawned() -> bool:
	return not sprite.visible

func set_paddle(paddle: Node2D) -> void:
	paddle.transform = transform
	var center_dir = (_get_viewport_center() - transform.origin).normalized()
	paddle.transform.origin += center_dir * player_wall_offset
	set_collision_layer_bit(5, false)
	sprite.hide()

func _get_viewport_center() -> Vector2:
	var rect = get_viewport_rect().size
	return rect / 2
