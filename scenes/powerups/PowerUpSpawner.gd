extends Node2D

export var initial_delay = 10
export var spawn_time = 1
export var max_power_ups = 3
export var powerup_distance = 10

export var collision_shape_path: NodePath
onready var collision_shape: CollisionShape2D = get_node(collision_shape_path)

onready var timer = $SpawnTimer
onready var delay_timer = $SpawnDelay

var power_ups = [
	preload("res://scenes/powerups/SpeedBall.tscn"),
	preload("res://scenes/powerups/SpeedPaddle.tscn"),
	preload("res://scenes/powerups/MultiplyBall.tscn"),
]


func start():
	delay_timer.start(initial_delay)


func get_random_powerup() -> PowerUp:
	return power_ups[randi() % power_ups.size()].instance()


func get_random_position() -> Vector2:
	var size = collision_shape.shape as RectangleShape2D
	var spawn_width = size.extents.x
	var spawn_height = size.extents.y
	return Vector2(
		rand_range(global_position.x - spawn_width, global_position.x + spawn_width),
		rand_range(global_position.y - spawn_height, global_position.y + spawn_height)
	)


func get_free_position() -> Vector2:
	var pos = get_random_position()
	var tries = 0 # Prevent infinite loop
	while is_powerup_too_close(pos) and tries <= 1000:
		pos = get_random_position()
		tries += 1
		
	if tries >= 1000:
		print("reached max retries for spawning power ups")
	return pos
	

func is_powerup_too_close(pos: Vector2) -> bool:
	for powerup in get_tree().get_nodes_in_group("PowerUp"):
		if pos.distance_to(powerup.global_position) <= powerup_distance:
			return true
	return false


func _on_SpawnTimer_timeout():
	if get_tree().get_nodes_in_group("PowerUp").size() >= max_power_ups:
		return
		
	var powerup = get_random_powerup()

	add_child(powerup)
	powerup.global_position = get_free_position()


func _on_SpawnDelay_timeout():
	timer.start(spawn_time)
