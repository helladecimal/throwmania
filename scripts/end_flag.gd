extends Area2D
## Touching this flag finishes the level and loads the next one.

var reached := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if reached or not body is Player:
		return
	reached = true
	get_tree().call_group("level_manager", "next_level")
