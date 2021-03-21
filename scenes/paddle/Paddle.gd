extends KinematicBody2D

export var speed = 200
export var acceleration = 1500

var ctrl: PaddleController
var velocity = Vector2.ZERO

func _physics_process(delta):
	if not ctrl: return
	
	var motion = ctrl.get_motion()
	velocity = velocity.move_toward(motion * speed, acceleration * delta)
	velocity = move_and_slide(velocity)
