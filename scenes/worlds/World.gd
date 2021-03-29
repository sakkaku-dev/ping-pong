extends Node2D

signal ball_spawned

const paddle = preload("res://scenes/paddle/Paddle.tscn")
const player_ctrl = preload("res://scenes/controller/PlayerController.tscn")
const bot_ctrl = preload("res://scenes/controller/BotController.tscn")

export var ball_spawner_path: NodePath
onready var ball_spawner = get_node(ball_spawner_path)

onready var spawn_timer = $SpawnTimer
onready var powerup_spawner = $PowerUpSpawner
onready var light = $BallSpawner/Light2D

var walls = []
var bots = []

func _ready():
	for child in get_children():
		if child is Wall:
			child.connect("ball_passed", self, "_wall_spawn")
			walls.append(child)


func start_game():
	spawn_ball()
	powerup_spawner.start()


func _wall_spawn() -> void:
	light.show()
	spawn_timer.start()


func spawn_ball():
	if get_tree().get_nodes_in_group("Ball").size() > 0:
		return

	var ball = ball_spawner.spawn()
	add_child(ball)
	ball.set_physics_process(false)
	emit_signal("ball_spawned")
	light.hide()

func spawn_bot() -> void:
	var ctrl = bot_ctrl.instance()
	if _spawn_paddle_for_ctrl(ctrl):
		bots.append(ctrl)
		print("Spawn Bot")


func spawn_player(event: InputEvent) -> PlayerInput:
	var ctrl = player_ctrl.instance()
	if _spawn_paddle_for_ctrl(ctrl):
		ctrl.input.set_for_event(event)
		print("Spawn " + str(event))
	return ctrl.input


func _spawn_paddle_for_ctrl(ctrl: PaddleController) -> bool:
	var paddle_instance = paddle.instance()
	paddle_instance.ctrl = ctrl
	paddle_instance.add_child(ctrl)

	add_child(paddle_instance)

	var wall = get_first_available_wall()
	if wall:
		wall.set_paddle(paddle_instance)
		return true
	else:
		print("No available walls anymore")

	return false

func get_first_available_wall() -> Node2D:
	for wall in walls:
		if not wall.is_paddle_spawned():
			return wall
	return null


func _get_viewport_center() -> Vector2:
	var rect = get_viewport_rect().size
	return rect / 2
