extends RigidBody2D
class_name Player

@export var health = 100
@export var moving = false
@onready var powerbar: ColorRect = $powerbar

var power = 70.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var mouse_pos = get_local_mouse_position()
var mouse_dir = atan2(mouse_pos.y, mouse_pos.x) + 3*PI/2
func throw(speed):
	print(speed)
	var offset = mouse_pos.normalized() * 40
	var ball_sc: PackedScene = load("res://scenes/ball.tscn")
	var ball = ball_sc.instantiate()
	ball.position = position + offset
	add_child(ball)
	
	ball.linear_velocity = mouse_pos.normalized() * speed
	pass

func _physics_process(delta: float) -> void:
	move_and_collide(linear_velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_pos = get_local_mouse_position()
	mouse_dir = atan2(mouse_pos.y, mouse_pos.x) + 3*PI/2
	
	var ball_speed = mouse_pos.length() if mouse_pos.length() < 100 else 100
	if not moving and Input.is_action_pressed("LMB"):
		
		print(ball_speed)
		
		powerbar.visible = true
		powerbar.size.y = ball_speed 
		powerbar.rotation = mouse_dir
	else:
		powerbar.visible = false
	
	if not moving and Input.is_action_just_released("LMB"):
		throw((ball_speed/100.0) * power)
		pass
		
	pass
