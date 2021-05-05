extends Area2D

var ongoing
var initial_position 

onready var shape = $CollisionShape2D

signal mov()

func _ready():
	self.connect("mov", get_tree().get_root().get_node("Main/Game/SantaClaus"), "on_Mov")
	
func event_is_inside_boundary(pos):
	return pos < position + shape.get_shape().get_extents() and pos > position - shape.get_shape().get_extents()
	
func _input(event):
	if event is InputEventScreenTouch and event.is_pressed() and ongoing != event.get_index() and event_is_inside_boundary(event.position):
		initial_position = event.position
		ongoing = event.index
		
	if event is InputEventScreenTouch and !event.is_pressed() and ongoing == event.get_index():
		emit_signal("mov", sign(event.position.y - initial_position.y))
		ongoing = -1
