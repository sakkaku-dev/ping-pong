extends Node2D

onready var world = $World
onready var start_menu = $CanvasLayer/MarginContainer/CenterContainer/StartMenu
onready var bgm = $BGM

var started = false
var host_input: PlayerInput

func _ready():
	randomize()
	start_menu.show()

func _unhandled_input(event: InputEvent):
	if not started and event.is_action("join"):
		var input = world.spawn_player(event)
		if not host_input:
			host_input = input


func _on_Start_pressed():
	started = true
	start_menu.hide()
	world.start_game()
	bgm.play()


func _on_Bot_pressed():
	world.spawn_bot()
