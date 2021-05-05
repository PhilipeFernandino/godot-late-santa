extends Sprite

export(Array, Texture) var sprite

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	set_texture(sprite[rng.randi_range(0, sprite.size() - 1)])

