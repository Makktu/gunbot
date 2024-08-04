extends CharacterBody2D

@onready var explosion = $CPUParticles2D
signal hit

func _ready():
	scale.x = 0.2
	scale.y = 0.2
	$AnimationPlayer.play('fade_in')
	
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_collision_area_area_entered(area):
	if area.name == 'bullet_area':
		explosion.emitting = true
		$Sprite2D.visible = false
		hit.emit()

func _on_cpu_particles_2d_finished():
	print('ehehe?')
	queue_free()
