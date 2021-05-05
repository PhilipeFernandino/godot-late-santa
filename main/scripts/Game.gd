extends Node2D

onready var santa = $SantaClaus
onready var camera = $Camera

signal achievement()

#Cenas
var chimney_scene = preload("res://chimney/Chimney.tscn")
var cookie_scene = preload("res://collectables/cookie/Cookie.tscn")
var snowball_scene = preload("res://enemies/snowball/Snowball.tscn")
var gift_scene = preload("res://gift/Gift.tscn")

var rng = RandomNumberGenerator.new()
var __delta = 0
var santa_sprite_size = Vector2(420, 186)
var pivos 

export(Curve) var diff_curve

#Gift control variables
var gift = Array()
var can_drop = true
var gift_drop_rate = 0.4

#GUI control variables
var score = 0 
var cookies = 0

export(bool) var cookie_on = true
export(bool) var snowball_on = true
export(bool) var chimney_on = true
var available_pivos

var cookie_pattern = [
	#Pattern 1
	[[0, 0, 1],
	[0, 1, 0],
	[1, 0, 0]],
	#Pattern 2
	[[0, 0, 0],
	[1, 1, 1],
	[0, 0, 0]],
	#Pattern 3
	[[1, 0, 1],
	[0, 1, 0],
	[0, 0, 0]],
	]
	
var fat_cookie_pattern = [
	[[1, 1, 1, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 1, 1, 1, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 1, 1, 1]]
	#Fim
]

#Funções virtuais
func _ready():
	#Inicia variáveis
	pivos = get_tree().get_nodes_in_group("pivo")
		
	available_pivos = [true, true, true]		
	
	start_invoking_chimney()
	
var time = -5
var turns = 0
var first_diff_period = 30
var diff_period = 60 #in seconds
var diff_interpolate = 0

var time_since_last_spawn_sb = 0

var time_since_last_spawn_ck = 0

func _physics_process(delta):
	time += delta
	time_since_last_spawn_sb += delta	
	time_since_last_spawn_ck += delta
	spawn_controller()
	
func rand():
	rng.randomize()
	
func spawn_controller(value = 0):
	
	if turns == 0 and time > first_diff_period or time > diff_period:
		time = -10
		turns += 1
		
	diff_interpolate = diff_curve.interpolate(time / diff_period)	
	
	if snowball_on:
		snowball_spawner()
	if cookie_on:
		cookie_spawner()

func cookie_spawner():
	if time > 0 or time_since_last_spawn_ck < 5:
		return
	
	time_since_last_spawn_ck = 0
	spawn_cookies_from_pattern(turns)
	
func snowball_spawner():
	if time_since_last_spawn_sb < 	7 - diff_interpolate / 20 or time < 0: # 7 ao 3
		return 
	
	time_since_last_spawn_sb = 0
		
	var pivo = -1
	if santa.time_on_current_pivo >  5 - diff_interpolate / 20: # 5 ao 1 
		pivo = santa.current_pivo
	
	var snowballs_to_spawn = floor(diff_interpolate / 33) + 1
	
	var snowballs_to_spawn_deferred = snowballs_to_spawn - 2
	snowballs_to_spawn -= snowballs_to_spawn_deferred
		
	new_snowball(snowballs_to_spawn, pivo)
	new_snowball_deferred(snowballs_to_spawn_deferred, (7 - diff_interpolate / 20 ) * 3, pivo)
	
func new_snowball_deferred(qt, time, _pivo = -1):
	if !snowball_on:
		return
	for j in qt:
		yield(get_tree().create_timer(time), "timeout")
		var av = Array()
		for i in available_pivos.size():
			if available_pivos[i]:
				av.append(i)
		if av.size() <= 0:
			return 0
		
		rng.randomize()
		var snowball = snowball_scene.instance()
		
		var pivo
		add_child(snowball)
		if _pivo == -1 or (_pivo!= -1 and !available_pivos[_pivo]):
			pivo = av[rng.randi_range(0, av.size() - 1)]
		else:
				pivo = _pivo
			
			
		available_pivos[pivo] = false
		snowball.pivo = pivo
		snowball.global_position.y = pivos[pivo].global_position.y
		
func new_snowball(qt, _pivo = -1):
	if !snowball_on:
		return
	for j in qt:
		
		var av = Array()
		for i in available_pivos.size():
			if available_pivos[i]:
				av.append(i)
		if av.size() <= 0:
			return 0
		
		rng.randomize()
		var snowball = snowball_scene.instance()
		
		var pivo
		add_child(snowball)
		if _pivo == -1 or (_pivo!= -1 and !available_pivos[_pivo]):
			pivo = av[rng.randi_range(0, av.size() - 1)]
		else:
				pivo = _pivo
			
			
		available_pivos[pivo] = false
		snowball.pivo = pivo
		snowball.global_position.y = pivos[pivo].global_position.y
		
func clear_pivo(pivo):
	available_pivos[pivo] = true
	
#Chimney
func start_invoking_chimney():
	yield(get_tree().create_timer(2.4 / santa.get_frag() , false), "timeout")
	new_chimney()
	start_invoking_chimney()
	
func new_chimney():
	rng.randomize()
	var chimney = chimney_scene.instance()
	add_child(chimney)
	chimney.global_position = Vector2(camera.global_position.x + 1920 + chimney.find_node("Chimney_Sprite").get_rect().size.x, pivos[rng.randi_range(6, 8)].global_position.y) * camera.zoom
	chimney.z_as_relative = false
	chimney.z_index = 4
	
#cookie
func spawn_cookies_from_pattern(value):
	rand()
	var obj
	if value < 2:
		obj = cookie_pattern[rng.randi_range(0, cookie_pattern.size() - 1)]
	else:
		obj = fat_cookie_pattern[rng.randi_range(0, fat_cookie_pattern.size() - 1)]
		
	for x in obj.size():
		for y in obj[x].size():
			if obj[x][y] == 1:
				new_cookie(Vector2(y, x))
	
func new_cookie(pos):
	var cookie = cookie_scene.instance()
	add_child(cookie)
	cookie.global_position = Vector2(get_camera_pos().x + 1920 + 150 * pos.x, pivos[pos.y].global_position.y)

#Gift				
func on_new_Gift():
		if can_drop and !get_tree().paused and santa.state == 0:
			can_drop = false
			gift.append(gift_scene.instance())
			var index  = gift.size() - 1
			add_child(gift[index])
			gift[index].global_position = santa.global_position
			gift[index].apply_impulse(Vector2(0, 0), Vector2(santa.base_velocity.x, 200))
			yield(get_tree().create_timer(gift_drop_rate, false), "timeout")
			can_drop = true
			

func get_camera_pos():
	return camera.global_position
				
func gift_achiev(status):
	if status.miss == -1 :
		emit_signal("achievement", "the_first_step")

#Sinais
func on_Gift_status_received(status):
	if status.miss == -1:
		score += 1
	gift_achiev(status)
	
func game_over():
	santa.stop()
	snowball_on = false
