extends Area2D

var pivo = -1 #Relacionado a posiçao em que a bola de neve foi spawnada no $Game
var time = 0

signal clear_pivo()

func _ready():
	self.connect("clear_pivo", get_parent(), "clear_pivo")
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_VisibilityNotifier2D_screen_entered():
	emit_signal("clear_pivo", pivo)
