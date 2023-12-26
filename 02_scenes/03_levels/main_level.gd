extends Node2D

const EXPERIENCE_REDUCTION_FACTOR = 0.8

var level_stats: LevelStats

var shooter_enemy_scene = preload("res://02_scenes/01_characters/shooter_enemy.tscn")
var simple_enemy_scene = preload("res://02_scenes/01_characters/simple_enemy.tscn")
var experience_scene = load("res://02_scenes/02_objects/experience.tscn")

var experience = 0
# this variable is used to level up faster. it is the experience value

var debug_pressed = false

func _ready():
	initialize_igor()
	initialize_level_stats()
	set_up_timer()
   
func _process(delta):
	update_exp_progress_bar()
	
	#TODO: delete this: this is a debug feature
	if !debug_pressed and Input.is_key_pressed(KEY_1):
		$igor.process_upgrade(HealUpgrade.new())
		debug_pressed = true
	
func _on_end_game():
	#TODO
	pass

func _on_spawn_enemies_timeout():
	spawn_enemy()
	
func _spawn_exp(position):
	var experience_instance = experience_scene.instantiate()
	experience_instance.position = position
	experience_instance.connect("on_exp_collected", _on_exp_collected) 
	add_child(experience_instance)
	
func _on_exp_collected():
	experience += level_stats.experience_factor
	
	if experience >= 100:
		on_exp_level_reached()
		experience = 0
		level_stats.experience_factor *= EXPERIENCE_REDUCTION_FACTOR
		print(level_stats.experience_factor)
	print("experience: " + str(experience))

func update_exp_progress_bar():
	#TODO: probablemente aquí tendré que añadir los niveles máximos de experiencia del nivel
	$hud.update_exp(experience) 

func on_exp_level_reached():
	pause_game()

func initialize_igor():
	$igor.position = Vector2(1080, 1080)
	$igor.connect("end_game", _on_end_game)
	
func initialize_level_stats():
	level_stats = LevelStats.new()
	
func set_up_timer():
	$spawn_enemies.wait_time = level_stats.spawn_enemy_time

func spawn_enemy():
	var random_point = get_random_point()
	var should_spawn_shooter = randi_range(0, 1)
	var enemy_instance
	
	if should_spawn_shooter:
		enemy_instance = shooter_enemy_scene.instantiate()
		enemy_instance.initialize_shooter_enemy($igor, level_stats.shooter_enemy_health, level_stats.enemy_movement_speed, level_stats.enemy_melee_damage, level_stats.enemy_projectile_damage, level_stats.enemy_shooting_speed, level_stats.enemy_projectile_speed)
	else:
		enemy_instance = simple_enemy_scene.instantiate()
		enemy_instance.initialize_simple_enemy($igor, level_stats.simple_enemy_health, level_stats.enemy_movement_speed, level_stats.enemy_melee_damage)
	
	if enemy_instance is SimpleEnemy:
		enemy_instance.position = random_point
		enemy_instance.connect("spawn_exp", _spawn_exp)
		add_child(enemy_instance)

func get_random_point():
	var radius = 1075
	var center = Vector2(1080, 1080)
	var random_angle = randf_range(0, 2 * PI)
	var random_radius = sqrt(randf()) * radius
	var x = center.x + random_radius * cos(random_angle)
	var y = center.y + random_radius * sin(random_angle)
	
	return Vector2(x, y)

func pause_game():
	get_tree().paused = true
