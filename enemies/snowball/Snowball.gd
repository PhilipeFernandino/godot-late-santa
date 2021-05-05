extends KinematicBody2D

onready var particles = $CanvasLayer/Particles

var velocity = Vector2(1200.0, 0.0)
var pivo = -1 #Relacionado a posiçao em que a bola de neve foi spawnada no $Game
var cam_pos
var time = 0

signal snowball_hit()
signal clear_pivo()

func _ready():
	set_physics_process(false)
	particles.position.x = 1920
	self.connect("clear_pivo", get_parent(), "clear_pivo")

func _process(delta):
	cam_pos = get_parent().get_camera_pos()
	global_position.x = cam_pos.x + 1920 + 125/2
	particles.position.y = position.y
	time += delta
	if time >= 2.0:
		emit_signal("clear_pivo", pivo)
		particles.emitting = false
		set_process(false)
		set_physics_process(true)
		
func _physics_process(delta):
	move_and_collide(-velocity * delta)
	rotation -= 0.15
	
func _on_Area2D_body_entered(_body):
	$Snowball_Sprite.hide()
	$DieParticles.set_emitting(true)
	rotation = 0 
	set_physics_process(false)
	set_process(false)
	get_tree().get_root().get_node("Main").game_over()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

