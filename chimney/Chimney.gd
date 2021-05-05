extends KinematicBody2D

var delivered : bool = false
var rng = RandomNumberGenerator.new()
var bodies = Array()
onready var audio = $AudioStreamPlayer

signal not_delivered()
signal player_collided()

func _ready():
	rng.randomize()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_Deliver_Area2D_body_entered(_body):
	if !bodies.has(_body.name):
		bodies.append(_body.name)
		audio._set_playing(true)
		delivered = true
		_body.status.miss =  -1
	
func _on_Collision_Area2D_body_entered(_body):
	emit_signal("player_collided")
