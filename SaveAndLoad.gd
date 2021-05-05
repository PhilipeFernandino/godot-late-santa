extends Node

var game_data = {
	"gifts" : 0,
	"cookies" : 0,
}

var config_data = {
	"music" : true,
	"soundfx" : true
}

func _ready():
	var f = File.new()
	if !f.file_exists("user://game_data.bin"):
		save_data("user://game_data.bin", game_data)
	else:
		game_data = load_data("user://game_data.bin")
	
	if !f.file_exists("user://config.bin"):
		save_data("user://config.bin", config_data)
	else:
		config_data = load_data("user://config.bin")
	
	
	f.close()
	print(game_data)
	save_data("user://game_data.bin", game_data)

func _process(delta):
	save_intermitent(delta)
	
func save_data(path = "user://game_data.bin", data = game_data):
	var f = File.new()
	var err = f.open_encrypted_with_pass(path, File.WRITE, OS.get_unique_id())
	if err != 0:
		print("Save data error" + str(err))
	f.store_var(data)
	f.close()

func load_data(path):
	var f = File.new()
	if f.file_exists(path):
		var err = f.open_encrypted_with_pass(path, File.READ, OS.get_unique_id())
		if err != 0:
			print("Load data error" + str(err))
		var data = f.get_var()
		f.close()
		return data
	else:
		return null

var time_elapsed = 0
func save_intermitent(delta):
	time_elapsed += delta
	if time_elapsed > 15:
		time_elapsed = 0
		save_data()
	
