extends KinematicBody2D

class_name Paddle

signal scored

export var speed = 200

var ctrl: PaddleController
var velocity = Vector2.ZERO
var lock_direction = Vector2.ZERO setget set_lock_direction
var lock_position = Vector2.ZERO

func set_lock_direction(dir: Vector2) -> void:
	lock_direction = dir
	lock_position = global_position

func _physics_process(_delta):
	if not ctrl: return
	
	var motion = ctrl.get_motion(self)
	velocity = motion * speed

	velocity = update_lock_direction(velocity, Vector2(0, 0))
	velocity = move_and_slide(velocity)

	# make sure it does not move in a locked direction
	global_position = update_lock_direction(global_position, lock_position)


func update_lock_direction(vec: Vector2, new: Vector2) -> Vector2:
	if lock_direction.y != 0:
		vec.x = new.x
	elif lock_direction.x != 0:
		vec.y = new.y
	return vec


func get_lock_axis_value(vec: Vector2):
	if lock_direction.y != 0:
		return vec.x
	elif lock_direction.x != 0:
		return vec.y

	return 0


func scored():
	emit_signal("scored")
