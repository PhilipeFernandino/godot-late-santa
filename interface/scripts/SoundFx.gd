extends TouchScreenButton

export(Array, Texture) var textures 

func set_texture(idx):
	normal = textures[idx]

var config_data

func _ready():
	config_data = SaveAndLoad.load_data("user://config.bin")
	set_volume()
	
func set_volume():
	if config_data.soundfx:
		set_texture(0)
		AudioServer.set_bus_volume_db(2, 0)
	else:
		set_texture(1)
		AudioServer.set_bus_volume_db(2, -80)
	
func _on_SoundFx_pressed():
	config_data.soundfx = !config_data.soundfx
	set_volume()
	SaveAndLoad.save_data("user://config.bin", config_data)
