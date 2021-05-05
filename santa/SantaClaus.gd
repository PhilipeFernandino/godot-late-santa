extends KinematicBody2D

var base_velocity = Vector2(400.0, 0.0)
const init_velocity = Vector2(400, 0.0)
const max_velocity = Vector2(600.0, 0.0)
var pivos = Array()
var current_pivo = 1
var time_on_current_pivo = 0
var target_pivo = current_pivo
var value = 0
var state = 0 

func get_frag():
	return base_velocity.x / init_velocity.x

func _ready():
	#Corrigindo posição inicial
	pivos = get_tree().get_nodes_in_group("pivo")
	print(pivos)
	global_position.y = pivos[current_pivo].global_position.y

func _physics_process(delta):
	
	if state == 0:
		time_on_current_pivo += delta
		
		if base_velocity < max_velocity:
			base_velocity.x += 0.03
		move_and_slide(base_velocity)
		
		if target_pivo > current_pivo:
			global_position.y += 15
		if target_pivo < current_pivo:
			global_position.y -= 15
		
	
		if floor(global_position.y) == floor(pivos[target_pivo].global_position.y):
			current_pivo = target_pivo
	
	if state == 1:
		move_and_slide(Vector2(60, 30))
		if rotation_degrees > 45:
			rotation_degrees += 1
		$Santa_Sprite.playing = false
		
func stop():
	state = 1
	
func on_Mov(_value):
	if _value == -1 and current_pivo > 0:
		target_pivo = current_pivo - 1
	if _value == 1 and current_pivo < 2:
		target_pivo = current_pivo + 1
	if value != 0:
		time_on_current_pivo = 0			
		
