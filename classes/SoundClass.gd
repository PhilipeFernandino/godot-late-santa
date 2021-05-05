extends AudioStreamPlayer

export(Array, AudioStream) var sounds

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	set_stream(sounds[rng.randi_range(0, sounds.size() - 1)])
