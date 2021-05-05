extends AnimatedSprite

var ok = false

func _ready():
	_set_playing(true)
	
func _on_Warning_animation_finished():
	ok = true
