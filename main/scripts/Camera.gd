extends Camera2D

onready var santa = get_parent().find_node("SantaClaus")
var send = false

signal pos_reached()

var shaking = false
var shake_duration
var shake_amplitude
var time_elapsed = 0
var rng = RandomNumberGenerator.new()

func _physics_process(delta):
	if santa.global_position.x - 500 > global_position.x:
		if !send:
			self.connect("pos_reached", get_tree().get_root().get_node("Main/InGameUI"), "on_Pos_reached")
			send = true
			emit_signal("pos_reached")
		if santa.state == 0:
			global_position.x += santa.base_velocity.x * delta
	
	if shaking == true:
		time_elapsed += delta
		shake(delta)

func shake(delta = 0):
	if time_elapsed > shake_duration:
		shaking = false
		offset = Vector2(0, 0)
	else:
		rng.randomize()
		offset = Vector2(rng.randi_range(1, 10) * shake_amplitude, rng.randi_range(1, 10) * shake_amplitude)
		
func set_shake(duration, amplitude):
	time_elapsed = 0
	shaking = true
	shake_duration = duration
	shake_amplitude = amplitude
	shake()
	
func restart():
	global_position.x = santa.global_position.x + 300
