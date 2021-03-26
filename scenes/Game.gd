extends Node2D

onready var world = $World
onready var start_menu = $CanvasLayer/MarginContainer/CenterContainer/StartMenu
onready var bgm = $BGM

var host_input: PlayerInput

func _ready():
	randomize()
	start_menu.show()

func _unhandled_input(event: InputEvent):
	if event.is_action("ui_accept"):
		var input = world.spawn_player(event)
		if not host_input:
			host_input = input


func _on_Start_pressed():
	start_menu.hide()
	world.spawn_ball()
	bgm.play()


func _on_Bot_pressed():
	world.spawn_bot()
