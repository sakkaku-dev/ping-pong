extends PowerUp

onready var timer = $Timer

export var speed_multiplier = 2

var pickup_ball: Ball

func on_pickup(ball: Ball) -> void:
	pickup_ball = ball
	ball.speed *= speed_multiplier
	timer.start()


func _on_Timer_timeout():
	if pickup_ball: # is empty if ball was already deleted
		pickup_ball.speed /= speed_multiplier
	queue_free()
