extends PaddleController

export var follow_distance = 150

var ball: Node2D

func get_motion(paddle: Paddle) -> Vector2:
	if ball:
		var pos = paddle.get_lock_axis_value(paddle.global_position)
		var ball_pos = paddle.get_lock_axis_value(ball.global_position)
		
		if abs(ball_pos - pos) <= follow_distance:
			return paddle.global_position.direction_to(ball.global_position).normalized()
	return Vector2.ZERO
