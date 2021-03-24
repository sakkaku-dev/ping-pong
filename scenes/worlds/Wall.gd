extends StaticBody2D

class_name Wall

signal ball_passed

export var player_wall_offset = 10
export var lock_direction = Vector2.ZERO

export var score_path: NodePath
onready var score = get_node(score_path)

onready var sprite = $Sprite

func is_paddle_spawned() -> bool:
	return not sprite.visible

func set_paddle(paddle: Paddle) -> void:
	paddle.transform = transform
	var center_dir = (_get_viewport_center() - transform.origin).normalized()
	paddle.transform.origin += center_dir * player_wall_offset
	paddle.lock_direction = lock_direction
	paddle.connect("scored", score, "scored")
	set_collision_layer_bit(5, false)
	sprite.hide()


func _get_viewport_center() -> Vector2:
	var rect = get_viewport_rect().size
	return rect / 2


func _on_Area2D_body_entered(body: Node):
	body.queue_free()
	if body is Ball and body.paddle:
		body.paddle.emit_signal("scored")
	emit_signal("ball_passed")
