extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var lvl: Level = get_parent()
		lvl.get_tree().change_scene_to_file("res://scenes/levels/level_" + str(lvl.level) + ".tscn")
		
		body.reset()
	pass # Replace with function body.
