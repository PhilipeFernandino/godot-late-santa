extends RigidBody2D

export(Array, Texture) var gift_textures

var status = {
	"miss" : 0,
}

signal status()
signal placar_update()

func _ready():
	status.y_max = global_position.y
	self.connect("status", get_parent(), "on_Gift_status_received")
	self.connect("placar_update", get_tree().get_root().get_node("Main/InGameUI/Placar/GiftPlacar"), "on_GiftPlacar_update")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if gift_textures.size() > 0:
		$Sprite.set_texture(gift_textures[rng.randi_range(0, gift_textures.size() - 1)])
	
func _process(delta):
	
	if global_position.y < status.y_max:
		status.y_max = global_position.y
	
	if status.miss != 0:
		emit_signal("status", status)
		if status.miss == -1:
			emit_signal("placar_update")
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	status.miss = 1
