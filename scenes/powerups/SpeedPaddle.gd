extends PowerUp

onready var timer = $Timer

export var speed_multiplier = 2

var paddle: Paddle

func on_pickup(ball: Ball) -> void:
	paddle = ball.paddle
	if paddle:
		paddle.speed *= speed_multiplier
	timer.start()


func _on_Timer_timeout():
	if paddle:
		paddle.speed /= speed_multiplier
	queue_free()
