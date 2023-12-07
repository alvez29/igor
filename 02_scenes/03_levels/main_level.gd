extends Node2D

var enemy_health = 10
var enemy_movement_speed = 300
var enemy_projectile_speed = 10
var enemy_shooting_speed = 1

var enemy_projectile_damage = 5
var enemy_melee_damage = 2

var shooter_enemy_scene = preload("res://02_scenes/01_characters/shooter_enemy.tscn")
var simple_enemy_scene = preload("res://02_scenes/01_characters/simple_enemy.tscn")

var spawn_enemy_time = 0.77

func _ready():
	initialize_igor()
	set_up_timer()
	#TODO: me quedo pegado en la pared

func _process(delta):
	pass
	
func _on_end_game():
	#TODO
	pass

func _on_enemy_hit(enemy_reference):
	enemy_reference.take_damage($igor.damage)

# on enemy hit player with projectile
func _on_player_shot():
	$igor.take_damage(enemy_projectile_damage)

# on enemy hit player with body
func _on_player_hit():
	$igor.take_damage(enemy_melee_damage)

func _on_spawn_enemies_timeout():
	spawn_enemy()

func initialize_igor():
	$igor.position = Vector2(1080, 1080)
	$igor.connect("player_shot", _on_player_shot)
	$igor.connect("player_hit", _on_player_hit)
	$igor.connect("end_game", _on_end_game)
	
func set_up_timer():
	$spawn_enemies.wait_time = spawn_enemy_time
	
func spawn_enemy():
	var random_point = get_random_point()
	var should_spawn_shooter = randi_range(0, 1)
	
	if should_spawn_shooter:
		var shooter_enemy_instance = shooter_enemy_scene.instantiate()
		shooter_enemy_instance.initialize_shooter_enemy($igor, enemy_health, enemy_movement_speed, enemy_shooting_speed, enemy_projectile_speed)
		shooter_enemy_instance.position = random_point
		shooter_enemy_instance.connect("enemy_hit", _on_enemy_hit)
		add_child(shooter_enemy_instance)
	else:
		var simple_enemy_instance = simple_enemy_scene.instantiate()
		simple_enemy_instance.initialize_simple_enemy($igor, enemy_health, enemy_movement_speed)
		simple_enemy_instance.position = random_point
		simple_enemy_instance.connect("enemy_hit", _on_enemy_hit)
		add_child(simple_enemy_instance)

func get_random_point():
	var radius = 1075
	var center = Vector2(1080, 1080)
	var random_angle = randf_range(0, 2 * PI)
	var random_radius = sqrt(randf()) * radius
	var x = center.x + random_radius * cos(random_angle)
	var y = center.y + random_radius * sin(random_angle)
	
	return Vector2(x, y)
