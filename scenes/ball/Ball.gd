extends KinematicBody2D

class_name Ball

export var speed = 100

var velocity = Vector2.ZERO
var paddle: Paddle


func _ready():
	set_physics_process(false)
	velocity.x = [-1, 1][randi() % 2]
	while abs(velocity.y) < 0.05: # Prevent to straight angles
		velocity.y = rand_range(-0.8, 0.8)

func _physics_process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		if collision.collider is Paddle:
			var lock_dir = 
			paddle = collision.collider
		velocity = velocity.bounce(collision.normal)
