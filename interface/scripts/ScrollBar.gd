extends Area2D

var default_value = SoundManager.get_bgm_volume_db()
onready var icon = $Bar_Icon
onready var shape = $Shape2D
var ongoing = -1
var ext 

func _ready():
	ext = shape.get_shape().get_extents() * 2
	icon.position.x =  ((80 - default_value)/80 * ext).x

func event_is_inside_boundary(pos):
	return pos.y < position.y + ext.y and pos.y > position.y and pos.x < position.x + ext.x and pos.x > position.x
	
func _input(event):
	if (event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed())) and event_is_inside_boundary(event.position):
		ongoing = event.get_index()
		icon.global_position.x = event.position.x
		SoundManager.set_bgm_volume_db(- 80 + (icon.position.x / ext.x) * 80)
		
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing:
		ongoing = -1
		
