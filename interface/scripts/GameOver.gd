extends TextureProgress

var time = 0
var sec = 10
onready var particles = $Particles
var rect = get_rect()

func start():
	set_process(true)
	value = 1000
	time = 0
	
func _ready():
	set_process(false)
	particles.position.y = rect.size.y / 2
	
func _process(delta):
	if value > 0:
		time += delta
		value = 1000 - (time * (max_value/sec))
	if value <= 0:
		get_tree().get_root().get_node("Main").restart()
		set_process(false)
	particles.position.x = rect.size.x * value/max_value
	
