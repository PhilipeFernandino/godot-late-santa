extends Sprite

var gifts = 0
onready var lbl = get_node("GiftPlacar_Label")

func on_GiftPlacar_update(value = 1):
	if value != -1:
		SaveAndLoad.game_data.gifts += value
		gifts += 1
	else:
		gifts = 0
	lbl.text = str(gifts)
	
func restart():
	gifts = 0
	on_GiftPlacar_update(-1)
