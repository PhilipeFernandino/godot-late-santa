extends Area2D

signal cookie_collected(value)

var rng = RandomNumberGenerator.new()
var __delta = 0

onready var sound_fx = $Cookie_Sound

func _ready():
	rng.randomize()
	self.connect("cookie_collected", get_tree().get_root().get_node("Main/InGameUI/Placar/CookiePlacar"), "on_CookiePlacar_update")
	
func _on_Cookie_body_entered(_body):
	emit_signal("cookie_collected")
	set_deferred("monitoring", false)
	if rng.randi_range(0, 10) > 5:
		sound_fx.play(0)
		sound_fx.set_pitch_scale(rng.randf_range(0.95, 1.05))
	$Particles2D.set_emitting(true)
	$Cookie_Sprite.visible = false
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
