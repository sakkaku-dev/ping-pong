extends Node2D

onready var world = $World

var host_input: PlayerInput

func _ready():
	randomize()

func _unhandled_input(event: InputEvent):
	if event.is_action("ui_accept"):
		var input = world.spawn_player(event)
		if not host_input:
			host_input = input

func _process(delta):
	if host_input and host_input.is_just_pressed("start"):
		world.spawn_ball()
