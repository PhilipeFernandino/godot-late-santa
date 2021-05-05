extends Node2D

var cookies = SaveAndLoad.game_data.cookies
var time_elapsed = 0
var visible_time = 5.5
var go_visible = false
onready var lbl = get_node("CookiePlacar_Label")

func _ready():
	on_CookiePlacar_update(0)

func _process(delta):
	if modulate.a > 0:
		time_elapsed += delta
		if time_elapsed > visible_time:
			modulate.a -= 0.02
		
	if go_visible:
		modulate.a += 0.05
		if modulate.a == 1:
			go_visible = false
		
func on_CookiePlacar_update(value = 1):
	lbl.text = str(SaveAndLoad.game_data.cookies)
	if value == 1:
		SaveAndLoad.game_data.cookies += value
		time_elapsed = 0
		go_visible = true
	
func restart():
	cookies = 0
	on_CookiePlacar_update(0)
