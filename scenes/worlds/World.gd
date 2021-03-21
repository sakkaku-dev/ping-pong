extends Node2D

const paddle = preload("res://scenes/paddle/Paddle.tscn")
const player_ctrl = preload("res://scenes/controller/PlayerController.tscn")

var walls = []

func _ready():
	for child in get_children():
		if child is Wall:
			walls.append(child)


func spawn_player(event: InputEvent):
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

func get_first_available_wall() -> Node2D:
	for wall in walls:
		if not wall.paddle_spawned:
			return wall
	return null
