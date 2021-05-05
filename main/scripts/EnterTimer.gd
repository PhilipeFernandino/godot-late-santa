extends Label


func _ready():
	var data = SaveAndLoad.load_data("user://game_data.bin")
	text = str(data.total_times_entered_in_the_game)
