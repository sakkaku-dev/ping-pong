extends KinematicBody2D

class_name Ball

export var speed = 50

onready var impact = $Impact

var velocity = Vector2.ZERO
var paddle: Paddle

var is_copy = false
	
func set_random_direction():
	velocity.x = [-1, 1][randi() % 2]
	while abs(velocity.y) < 0.05: # Prevent to straight angles
		velocity.y = rand_range(-0.8, 0.8)

func _physics_process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		impact.play()
		if collision.collider is Paddle:
			if collision.normal.dot(collision.collider.lock_direction) == 0:
				paddle = collision.collider
		velocity = velocity.bounce(collision.normal)

func copy() -> Ball:
	var ball = load("res://scenes/ball/Ball.tscn").instance()
	ball.speed = speed
	ball.paddle = paddle
	ball.velocity = velocity
	ball.global_position = global_position
	ball.is_copy = true
	return ball
