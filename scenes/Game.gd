extends Node2D

onready var world = $World


func _unhandled_input(event: InputEvent):
	if event.is_action("ui_accept"):
		world.spawn_player(event)

