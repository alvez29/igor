extends Node2D

const EXPERIENCE_REDUCTION_FACTOR = 0.8

#TODO: Añadir más rondas y equilibrar
var round_stats_by_rounds = [
	RoundStats.createRoundOneStats(),
	RoundStats.createRoundTwoStats(),
	RoundStats.createRoundThreeStats()
]

var round_stats:RoundStats

var shooter_enemy_scene = preload("res://02_scenes/01_characters/shooter_enemy.tscn")
var simple_enemy_scene = preload("res://02_scenes/01_characters/simple_enemy.tscn")
var experience_scene = load("res://02_scenes/02_objects/experience.tscn")

var round = 0
var experience = 0
# this variable is used to round up faster. it is the experience value
var experience_factor = 15

func _ready():
	initialize_igor()
	initialize_level_stats()
	set_up_timers()
   
func _process(delta):
	update_hud()

func _game_over():
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
	experience += experience_factor
	
	if experience >= 100:
		on_exp_level_reached()
		experience = 0
		experience_factor *= EXPERIENCE_REDUCTION_FACTOR
		print(experience_factor)
	print("experience: " + str(experience))

func update_hud():
	$hud.update_exp(experience)
	if !$round_timer.is_stopped():
		$hud.update_time(int($round_timer.time_left))

func on_exp_level_reached():
	$hud.show_random_stats_upgrades()
	pause_game()

func initialize_igor():
	$igor.position = Vector2(1080, 1080)
	$igor.connect("end_game", _game_over)
	
func initialize_level_stats():
	round_stats = round_stats_by_rounds[round]
	
func set_up_timers():
	$spawn_enemies.wait_time = round_stats.spawn_enemy_time
	$round_timer.wait_time = round_stats.round_time
	$round_timer.start()
	$spawn_enemies.start()

func spawn_enemy():
	var random_point = get_random_point()
	var should_spawn_shooter = randi_range(0, 1)
	var enemy_instance
	
	if should_spawn_shooter:
		enemy_instance = shooter_enemy_scene.instantiate()
		enemy_instance.initialize_shooter_enemy($igor, round_stats.shooter_enemy_health, round_stats.enemy_movement_speed, round_stats.enemy_melee_damage, round_stats.enemy_projectile_damage, round_stats.enemy_shooting_speed, round_stats.enemy_projectile_speed)
	else:
		enemy_instance = simple_enemy_scene.instantiate()
		enemy_instance.initialize_simple_enemy($igor, round_stats.simple_enemy_health, round_stats.enemy_movement_speed, round_stats.enemy_melee_damage)
	
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

func clear_round_enemies():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()

func pause_game():
	get_tree().paused = true
	
func next_round():
	round += 1
	
	if round < round_stats_by_rounds.size():
		round_stats = round_stats_by_rounds[round]
		$hud.update_round(round)
		set_up_timers()
		$hud.fade_time_in()
	else:
		win_game()
	

func win_game():
	#TODO
	print("Has acabado todas las rondas")
	pass

func _on_round_timer_timeout():
	$hud.fade_time_out()
	$spawn_enemies.stop()
	clear_round_enemies()
	$pre_round_wait_timer.start()

func _on_pre_round_wait_timer_timeout():
	next_round()

func _on_hud_upgrade_selected(upgrade):
	get_tree().paused = false
	$igor.process_upgrade(upgrade)
