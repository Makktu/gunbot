extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	scale.x = 0.2
	scale.y = 0.2
	$AnimationPlayer.play('fade_in')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	#if collision_info:
		#print(collision_info)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_collision_area_area_entered(area):
	if area.name == 'bullet_area':
		queue_free()
