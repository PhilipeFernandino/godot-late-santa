extends Control

var game
var ingame_ui 
var game_instance
var ingame_ui_instance
var game_over_ui_instance
var can_act = true

onready var atmosphere = $Atmosphere
onready var anim_player = $AnimationPlayer
onready var game_over_ui 
onready var black_screen = $CanvasModulate
var splash_screen_gone

func _ready():
	game = load("res://main/scenes/Game.tscn")
	ingame_ui = load("res://interface/scenes/InGameUI.tscn")
	game_over_ui = load("res://interface/scenes/GameOver_UI.tscn")
	
func start_music():
	yield(get_tree().create_timer(0.7), "timeout")
	splash_screen_gone = true

var game_over = false
func game_over():
	if !game_over:
		atmosphere.get_node("Snowflake").speed_scale = 0.2
		game_over = true
		SaveAndLoad.save_data()
		game_over_ui_instance = game_over_ui.instance()	
		$Game/Camera.set_shake(0.2, 1)
		add_child(game_over_ui_instance)
		game_instance.game_over()
	
func instantiate():
	game_instance =  game.instance()
	ingame_ui_instance = ingame_ui.instance()

func _free():
	game_instance.queue_free()
	ingame_ui_instance.queue_free()
	if is_instance_valid(game_over_ui_instance):
		game_over_ui_instance.queue_free()

var bs_on = 0
var time_on_bs

func _process(delta):
	if bs_on == 1 and black_screen.modulate.a < 1.0:
		black_screen.modulate.a = 1.0
	elif bs_on == -1 and black_screen.modulate.a > 0.0:
		black_screen.modulate.a -= 0.02
		
func set_black_screen(time):
	bs_on = 1
	time_on_bs = time
	yield(get_tree().create_timer(time), "timeout")
	bs_on = -1
	
func add_childs():
	add_child(game_instance)
	add_child(ingame_ui_instance)
	
func start_game():
	if splash_screen_gone:
		$StartScreen_UI.visible = false
		instantiate()
		add_childs()
		$Atmosphere.get_node("Snowflake").speed_scale = 1.0

func restart():
	set_black_screen(0.5)
	game_over = false
	atmosphere.get_node("Snowflake").speed_scale = 1.0
	_free()
	yield(game_instance, "tree_exited")
	yield(ingame_ui_instance, "tree_exited")
	instantiate()
	add_childs()

func go_home():
	set_black_screen(0.5)
	atmosphere.get_node("Snowflake").speed_scale = 1.0	
	game_over = false
	_free()
	$StartScreen_UI.visible = true
