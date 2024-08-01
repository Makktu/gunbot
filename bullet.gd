extends Area2D

@onready var explosion_frames = $explosion

var speed = 300
var movement_vector := Vector2(0, -1)
#var exploded_again := false
#


func _ready():
	#velocity = velocity.rotated(deg_to_rad(global_rotation_degrees))
	pass
	
func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	#if collision_info:
		##$Sprite2D.visible = false
		##$collision_particles.emitting = true
		#queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
