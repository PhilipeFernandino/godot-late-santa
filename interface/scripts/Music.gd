extends TouchScreenButton

export(Array, Texture) var textures 

func set_texture(idx):
	normal = textures[idx]

var config_data

func _ready():
	config_data = SaveAndLoad.load_data("user://config.bin")
	set_volume()
	
func set_volume():
	print(config_data.music)
	if config_data.music:
		set_texture(0)
		AudioServer.set_bus_volume_db(1, 0)
	else:
		set_texture(1)
		AudioServer.set_bus_volume_db(1, -80)
	print(config_data.music)
	
func _on_Music_pressed():
	config_data.music = !config_data.music
	set_volume()
	SaveAndLoad.save_data("user://config.bin", config_data)

