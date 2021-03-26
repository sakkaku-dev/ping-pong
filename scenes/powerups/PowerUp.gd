extends Area2D

class_name PowerUp

onready var pickup = $PickUp
onready var collision = $CollisionShape2D

func on_pickup(_ball: Ball) -> void:
	pass

func _on_PowerUp_body_entered(body):
	if body is Ball:
		pickup.play()
		on_pickup(body)
		hide()
		# Collision can be triggered even if hidden
		collision.set_deferred("disabled", true)
