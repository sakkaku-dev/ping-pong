extends Node2D

const paddle = preload("res://scenes/paddle/Paddle.tscn")
const player_ctrl = preload("res://scenes/controller/PlayerController.tscn")
const ball = preload("res://scenes/ball/Ball.tscn")

var walls = []

func _ready():
	for child in get_children():
		if child is Wall:
			child.connect("ball_passed", self, "call_deferred", ["spawn_ball"])
			walls.append(child)


func spawn_ball():
	var ball_instance = ball.instance()
	add_child(ball_instance)
	ball_instance.global_position = _get_viewport_center()


func spawn_player(event: InputEvent) -> PlayerInput:
	var paddle_instance = paddle.instance()
	var ctrl = player_ctrl.instance()
	paddle_instance.ctrl = ctrl
	paddle_instance.add_child(ctrl)

	add_child(paddle_instance)
	ctrl.input.set_for_event(event)

	print("Spawn " + str(event))
	var wall = get_first_available_wall()
	if wall:
		wall.set_paddle(paddle_instance)
	else:
		print("No available walls anymore")
	
	return ctrl.input

func get_first_available_wall() -> Node2D:
	for wall in walls:
		if not wall.is_paddle_spawned():
			return wall
	return null


func _get_viewport_center() -> Vector2:
	var rect = get_viewport_rect().size
	return rect / 2
