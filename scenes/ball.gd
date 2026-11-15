extends RigidBody2D
class_name Ball

@export var bounces = 0
@onready var timer = $Despawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bounces > 4 or timer.is_stopped():
		queue_free()
	pass


func _on_body_entered(body: Node) -> void:
	bounces += 1
	pass # Replace with function body.
