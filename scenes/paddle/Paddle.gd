extends KinematicBody2D

class_name Paddle

export var speed = 200
export var acceleration = 1500

var ctrl: PaddleController
var velocity = Vector2.ZERO
var lock_direction = Vector2.ZERO

func _physics_process(delta):
	if not ctrl: return
	
	var motion = ctrl.get_motion(self)
	velocity = velocity.move_toward(motion * speed, acceleration * delta)

	if lock_direction.y != 0:
		velocity.x = 0
	elif lock_direction.x != 0:
		velocity.y = 0

	velocity = move_and_slide(velocity)

func get_lock_axis_value(vec: Vector2):
	if lock_direction.y != 0:
		return vec.x
	elif lock_direction.x != 0:
		return vec.y

	return 0
