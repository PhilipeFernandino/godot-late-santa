extends CanvasLayer

onready var main = get_tree().get_root().get_node("Main")

func _ready():
	$Container/Bar.start()
	
func bar_finish():
	main.restart()

func _on_Revive_pressed():
	print("show_ad")

func _on_Restart_pressed():
	main.restart()

func _on_Home_pressed():
	main.go_home()
	
