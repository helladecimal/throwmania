extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar
@onready var main = $"../Main2D/Current Level"
@onready var player = main.get_children()[0].find_child("Player")
var label := Label.new()
var max_health := 100

func _ready() -> void:
	max_health = player.health
	health_bar.max_value = max_health
	health_bar.show_percentage = false
	health_bar.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	health_bar.custom_minimum_size = Vector2(300, 36)
	health_bar.offset_left = -150
	health_bar.offset_right = 150
	health_bar.offset_top = -70
	health_bar.offset_bottom = -34
	var fill := StyleBoxFlat.new()
	fill.bg_color = Color(0.2, 0.8, 0.3)
	fill.set_corner_radius_all(18)
	var bg := StyleBoxFlat.new()
	bg.bg_color = Color(0, 0, 0, 0.6)
	bg.set_corner_radius_all(18)
	health_bar.add_theme_stylebox_override("fill", fill)
	health_bar.add_theme_stylebox_override("background", bg)
	label.set_anchors_preset(Control.PRESET_FULL_RECT)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	health_bar.add_child(label)
	
func _process(_delta: float) -> void:
	health_bar.value = player.health
	label.text = "%d / %d" % [player.health, max_health]
