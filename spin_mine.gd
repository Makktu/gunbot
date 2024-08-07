extends CharacterBody2D

@onready var explosion = $CPUParticles2D
signal hit

func _ready():
	scale.x = 0.6
	scale.y = 0.6
	#$AnimationPlayer.play('fade_in')
	pass
	
func _physics_process(delta):
	var _collision_info = move_and_collide(velocity * delta)
	rotation += 2

#func _on_visible_on_screen_notifier_2d_screen_exited():
	#queue_free()

func _on_cpu_particles_2d_finished():
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_organic_collision_area_entered(area):
	print(area.name)
	if area.name == 'bullet_area':
		explosion.emitting = true
		$Sprite2D.visible = false
		hit.emit()
