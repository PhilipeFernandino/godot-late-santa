extends TextureRect

func _on_ConfigButton_pressed():
	visible = !visible

func _on_StartScreen_GUI_hide():
	hide()
