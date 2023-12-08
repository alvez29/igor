extends Node2D

#TODO: podría añadir un objeto que encapsulara los parámetros
var enemy_health = 20
var enemy_movement_speed = 300
var enemy_projectile_speed = 700
var enemy_shooting_speed = 1

var enemy_projectile_damage = 5
var enemy_melee_damage = 2

var shooter_enemy_scene = preload("res://02_scenes/01_characters/shooter_enemy.tscn")
var simple_enemy_scene = preload("res://02_scenes/01_characters/simple_enemy.tscn")
var experience_scene = load("res://02_scenes/02_objects/experience.tscn")

var spawn_enemy_time = 0.77
var experience = 0
# this variable is used to level up faster. it is the experience value
var experience_factor = 1.7

func _ready():
	initialize_igor()
	set_up_timer()
	#TODO: me quedo pegado en la pared

func _process(delta):
	update_exp_progress_bar()
	
func _on_end_game():
	#TODO
	pass

func _on_spawn_enemies_timeout():
	spawn_enemy()
	
func _spawn_exp(position):
	var experience_instance = experience_scene.instantiate()
	experience_instance.position = position
	experience_instance.set_factor(experience_factor)
	experience_instance.connect("on_exp_collected", _on_exp_collected) 
	add_child(experience_instance)
	
func _on_exp_collected(factor):
	experience += factor
	print("experience: " + str(experience))

func update_exp_progress_bar():
	#TODO: probablemente aquí tendré que añadir los niveles máximos de experiencia del nivel
	$igor/camera/exp_bar.value = experience

func initialize_igor():
	$igor.position = Vector2(1080, 1080)
	$igor.connect("end_game", _on_end_game)
	
func set_up_timer():
	$spawn_enemies.wait_time = spawn_enemy_time
	
func spawn_enemy():
	var random_point = get_random_point()
	var should_spawn_shooter = randi_range(0, 1)
	var enemy_instance
	
	if should_spawn_shooter:
		enemy_instance = shooter_enemy_scene.instantiate()
		enemy_instance.initialize_shooter_enemy($igor, enemy_health, enemy_movement_speed, enemy_melee_damage, enemy_projectile_damage, enemy_shooting_speed, enemy_projectile_speed)
	else:
		enemy_instance = simple_enemy_scene.instantiate()
		enemy_instance.initialize_simple_enemy($igor, enemy_health, enemy_movement_speed, enemy_melee_damage)
	
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
