extends RigidBody2D
class_name Player

@export var health = 100
@export var moving = false
@onready var powerbar: ColorRect = $powerbar

var power = 400.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func throw():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not moving and Input.is_action_pressed("LMB"):
		var mouse_pos = get_local_mouse_position()
		var ball_speed = mouse_pos.length()
		print(ball_speed)
		
		powerbar.visible = true
		powerbar.size.y = ball_speed
		powerbar.rotation = atan2(mouse_pos.y, mouse_pos.x)
		pass
		
	pass
