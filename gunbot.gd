extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).

@onready var muzzle = $firing_point
var screen_size # Size of the game window.

var shot_timer_active = false

const bullet = preload("res://bullet.tscn")

var rotation_speed = 0.25

signal hit
signal bullet_shot(bullet)

func _ready():
	pass
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _physics_process(delta):
	rotation_degrees += rotation_speed
	
func _process(delta):
	if Input.is_action_pressed("shoot") and !shot_timer_active:
		shot_timer_active = true
		#print('shot fired!')
		_shoot()
		$ShotTimer.start()

func _shoot():
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_position = muzzle.global_position
	#bullet_instance.rotation_degrees = global_rotation_degrees - 90
	bullet_instance.rotation = rotation
	emit_signal("bullet_shot", bullet_instance)
	get_parent().add_child(bullet_instance)
	#times_fired += 1
	#if (times_fired == firing_points) and firing_points == 1:
		#break
	#pass


func _on_body_entered(body):
	#print(body.name)
	#if body.name == 'bullet':
		#return
	# handle collision, damage, game over etc.
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)


func _on_shot_timer_timeout():
	shot_timer_active = false
	
	
