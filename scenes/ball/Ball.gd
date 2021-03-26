extends KinematicBody2D

class_name Ball

export var speed = 50

onready var impact = $Impact

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
		impact.play()
		if collision.collider is Paddle:
			if collision.normal.dot(collision.collider.lock_direction) == 0:
				paddle = collision.collider
		velocity = velocity.bounce(collision.normal)
