extends CanvasLayer

onready var menu = self.find_node("Menu")
onready var animation_player = self.find_node("AnimationPlayer")
onready var main = get_tree().get_root().get_node("Main")
onready var giftplacar = get_node("Placar/GiftPlacar")
onready var cookieplacar = get_node("Placar/CookiePlacar")

func _unpause():
	get_tree().set_pause(false)

func _pause():
	get_tree().set_pause(true)
	
func on_Pos_reached():
	animation_player.play("UI_show")

func restart():
	giftplacar.restart()
	cookieplacar.restart()
		
func _on_Config_Button_pressed():
	_pause()
	animation_player.play("Menu_show")
	
func _on_Resume_Button_pressed():
	_unpause()
	animation_player.play_backwards("Menu_show")
	
func _on_Restart_Button_pressed():
	_unpause()
	animation_player.play_backwards("Menu_show")
	main.restart()
	
func _on_Quit_Button_pressed():
	_unpause()
	main.go_home()
