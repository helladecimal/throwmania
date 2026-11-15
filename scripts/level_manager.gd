extends Node2D
## Swaps levels when the player reaches an EndFlag.
## The level already inside this node is level 1; list the rest here in order.

@export var next_levels: Array[PackedScene] = []
var level_index := 0

func _ready() -> void:
	add_to_group("level_manager")

func next_level() -> void:
	call_deferred("_load_next_level")

func _load_next_level() -> void:
	# No levels left: back to the main menu.
	if level_index >= next_levels.size():
		get_tree().change_scene_to_file("res://scenes/ui.tscn")
		return
	for child in get_children():
		child.queue_free()
	for node in get_tree().root.get_children():
		if node is Ball:
			node.queue_free()
	add_child(next_levels[level_index].instantiate())
	level_index += 1
	_reset_player()

func _reset_player() -> void:
	var player := get_node("../Player") as RigidBody2D
	player.linear_velocity = Vector2.ZERO
	player.angular_velocity = 0.0
	PhysicsServer2D.body_set_state(player.get_rid(), PhysicsServer2D.BODY_STATE_TRANSFORM, Transform2D(0.0, Vector2.ZERO))
	player.global_position = Vector2.ZERO
	var cam := player.get_node_or_null("Camera2D") as Camera2D
	if cam:
		cam.reset_smoothing()
