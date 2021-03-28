extends KinematicBody2D

class_name Ball

export var speed = 50

onready var impact = $Impact

const min_angle = deg2rad(30)

var velocity = Vector2.ZERO
var paddle: Paddle
	
func set_random_direction():
	velocity.x = [-1, 1][randi() % 2]
	while abs(velocity.y) < 0.05: # Prevent to straight angles
		velocity.y = rand_range(-0.8, 0.8)

func _physics_process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		impact.play()
		
		velocity = velocity.bounce(collision.normal)
		
		if collision.collider is Paddle:
			if collision.normal.dot(collision.collider.lock_direction) == 0:
				paddle = collision.collider
				
				var paddle_velocity = paddle.velocity.normalized()
				var angle = velocity.angle_to(paddle_velocity)
				if angle > min_angle:
					var diff = angle - min_angle
					velocity = velocity.rotated(min(angle * 0.3, diff))

func copy() -> Ball:
	var ball = load("res://scenes/ball/Ball.tscn").instance()
	ball.speed = speed
	ball.paddle = paddle
	ball.velocity = velocity
	ball.global_position = global_position
	return ball
