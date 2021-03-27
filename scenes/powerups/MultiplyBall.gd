extends PowerUp

# Includes the existing ball, meaning with 3 only 2 extra balls will be spawned
export var multiply_count = 3

func on_pickup(ball: Ball) -> void:
	var rotate_value = 360 / multiply_count
	for i in range(1, multiply_count):
		var copy: Ball = ball.copy()
		copy.set_physics_process(true)
		copy.velocity = copy.velocity.rotated(deg2rad(rotate_value) * i)
		ball.get_parent().call_deferred("add_child", copy)
	
	queue_free()
