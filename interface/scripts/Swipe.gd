extends TouchScreenButton

signal new_gift()

func _ready():
	self.connect("new_gift", get_tree().get_root().get_node("Main/Game"), "on_new_Gift")

func _on_ReleaseGift_Button_pressed():
	emit_signal("new_gift")
