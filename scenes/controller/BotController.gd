extends PaddleController

export var follow_distance = 150
export var stop_change_ball_distance = 10

var ball: Ball

func get_closest_ball(position: Vector2) -> Ball:
	var min_distance = -1
	var curr_ball = null
	
	for ball in get_tree().get_nodes_in_group("Ball"):
		var ball_distance = position.distance_to(ball.global_position)
		if ball_distance < min_distance or min_distance == -1:
			min_distance = ball_distance
			curr_ball = ball
	
	return curr_ball


func can_change_ball(position: Vector2) -> bool:
	return not ball or ball.global_position.distance_to(position) > stop_change_ball_distance


func get_motion(paddle: Paddle) -> Vector2:
	if can_change_ball(paddle.global_position):
		ball = get_closest_ball(paddle.global_position)
	if ball:
		var pos = paddle.get_lock_axis_value(paddle.global_position)
		var ball_pos = paddle.get_lock_axis_value(ball.global_position)
		
		if abs(ball_pos - pos) <= follow_distance:
			return paddle.global_position.direction_to(ball.global_position).normalized()
	return Vector2.ZERO
