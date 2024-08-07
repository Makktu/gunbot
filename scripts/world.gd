extends Node

@export var organic_scene: PackedScene
var spinning_mine_scene = preload("res://scenes/spin_mine.tscn")
@onready var bullets = $bullets_shot
@onready var gunbot = $gunbot
var score
var start_wave_speed = [10.0, 30.0]

func _ready():
	#gunbot.connect("bullet_shot", _on_gunbot_bullet_shot)
	play_random_track()
	new_game()
	
#func _on_gunbot_bullet_shot(bullet):
	#bullets.add_child(bullet)
	
func game_over():
	$OrganicTimer.stop()
	print('Game Over!')
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()
	
func new_game():
	$gunbot.start($Position.position)
	$OrganicTimer.start()
	$SpinMineTimer.start()

func _on_organic_timer_timeout():
	# Create a new instance of the Mob scene.
	var organic = organic_scene.instantiate()
	
	# Choose a random location on Path2D.
	var organic_spawn_location = $OrganicPath/SpawnLocation
	organic_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = organic_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	organic.position = organic_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	organic.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(start_wave_speed[0], start_wave_speed[1]), 0.0)
	organic.velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(organic)
	
	organic.hit.connect($UserInterface/ScoreLabel._on_enemy_destroyed.bind())


func _on_spin_mine_timer_timeout():
	# Create a new instance of the Mob scene.
	var spinner = spinning_mine_scene.instantiate()
	
	# Choose a random location on Path2D.
	var spinner_spawn_location = $OrganicPath/SpawnLocation
	spinner_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = spinner_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	spinner.position = spinner_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	spinner.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(start_wave_speed[0] * 2, start_wave_speed[1] * 2), 0.0)
	spinner.velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(spinner)
	
	spinner.hit.connect($UserInterface/ScoreLabel._on_enemy_destroyed.bind())
	
	$SpinMineTimer.start()
	
func play_random_track():
	var which_track = randf_range(1, 4)
	print('Which track:', which_track)
	if which_track < 2:
		$BackgroundMusic/game.play()
	elif which_track < 3:
		$BackgroundMusic/game2.play()
	else:
		$BackgroundMusic/game3.play()
		
