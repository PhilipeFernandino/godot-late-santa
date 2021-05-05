extends Area2D

export(Array, StreamTexture) var tree

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	if tree.size() > 0:
		$Tree_Sprite.set_texture(tree[rng.randi_range(0, tree.size() - 1)])
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
