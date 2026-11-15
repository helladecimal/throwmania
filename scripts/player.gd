extends RigidBody2D
class_name Player

@export var health = 100
@export var moving = false
@onready var powerbar: ColorRect = $powerbar
@onready var ray: RayCast2D = $RayCast2D

var power = 450.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()
	pass # Replace with function body.

func reset():
	position = get_parent().find_child("Current Level").get_children()[0].find_child("Spawn").position

var mouse_pos = get_local_mouse_position()
var mouse_dir = atan2(mouse_pos.y, mouse_pos.x) + 3*PI/2
func throw(speed):
	print(speed)
	var ball_sc: PackedScene = load("res://scenes/ball.tscn")
	var ball: Ball = ball_sc.instantiate()
	
	print(ray.get_collider())
	ray.target_position = mouse_pos.normalized() * 128
	print(position.distance_to(ray.get_collision_point()))
	var ray_offset = (position.distance_to(ray.get_collision_point()) + 2) if ray.is_colliding() else 128
	var offset = mouse_pos.normalized() * ray_offset
	ball.position = position + offset
	get_tree().root.add_child(ball)
	
	ball.apply_central_impulse(mouse_pos.normalized() * speed) 
	pass

func _physics_process(delta: float) -> void:
	linear_velocity *= 0.97

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_pos = get_local_mouse_position()
	
	var ball_speed = mouse_pos.length() if mouse_pos.length() < 200 else 200
	if not moving and Input.is_action_pressed("LMB"):
		
		print(ball_speed)
		
		powerbar.visible = true
		powerbar.size.y = ball_speed 
		powerbar.rotation = mouse_pos.angle() + 3*PI/2
	else:
		powerbar.visible = false
	
	if Input.is_action_just_pressed("Restart"):
		reset()
	
	if not moving and Input.is_action_just_released("LMB"):
		throw((ball_speed/100.0) * power)
		pass
		
	pass
