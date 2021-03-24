extends Control

onready var hide_timer = $HideTimer

func _ready():
	hide()


func _on_HideTimer_timeout():
	hide()


func show():
	.show()
	hide_timer.start()
