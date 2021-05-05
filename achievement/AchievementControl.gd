extends Control

onready var animation_player = $AnimationPlayer
var backwards = false
var achievement
var already_achieved = Array()
var queue = Array()
var available = true

func _ready():
	get_tree().get_root().get_node("Main/Game").connect("achievement", self, "on_Achievement")
	
func _process(_delta):
	if available and queue.size() > 0:
		play_from_queue()
		
func on_Achievement(name):       
	if !already_achieved.has(name):
		queue.append(name)
		already_achieved.append(name)
	
func play_from_queue():
	available = false
	achievement = load("res://achievement/achievements/" + queue[0] + ".tscn").instance()
	add_child(achievement)
	animation_player.play("achievement")
	backwards = false
		
func _on_AnimationPlayer_animation_finished(_anim_name):
	if !backwards:
		animation_player.play_backwards("achievement")
		backwards = true
	else:
		achievement.queue_free()
		queue.pop_front()
		available = true
