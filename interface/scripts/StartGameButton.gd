extends Button

signal start()

func _ready():
	var main = get_tree().get_root().get_node("Main")
	self.connect("start", main, "start_game")
	
func _on_StartGameButton_pressed():
	emit_signal("start")

