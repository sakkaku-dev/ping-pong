extends Position2D

const ball = preload("res://scenes/ball/Ball.tscn")

onready var timer = $SpawnTimer

var spawned_ball: Ball

func spawn() -> Ball:
	var ball_instance = ball.instance()
	ball_instance.set_physics_process(false)
	ball_instance.set_random_direction()
	ball_instance.global_position = global_position
	spawned_ball = ball_instance
	timer.start()
	return ball_instance


func _on_SpawnTimer_timeout():
	if spawned_ball:
		spawned_ball.set_physics_process(true)
