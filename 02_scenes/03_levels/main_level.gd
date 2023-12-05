extends Node2D

var rogi_scene = preload("res://02_scenes/01_characters/rogi.tscn")
var enemy_health = 50
var spawn_enemy_time = 1

func _ready():
	initialize_igor()
	set_up_timer()
	#TODO: me quedo pegado en la pared

func _process(delta):
	pass

func initialize_igor():
	$igor.position = Vector2(1080, 1080)
	
func set_up_timer():
	$spawn_enemies.wait_time = spawn_enemy_time
	$spawn_enemies.start()
	
func spawn_enemy():
	var random_point = get_random_point()
	print(random_point)
	#TODO: Comprobar que no haya ninguna entidad cerca
	var rogi_instance = rogi_scene.instantiate()
	rogi_instance.initialize_rogi($igor, 50, 300)
	rogi_instance.position = random_point
	add_child(rogi_instance)
	

func get_random_point():
	var radius = 1075
	var center = Vector2(1080, 1080)
	var random_angle = randf_range(0, 2 * PI)
	var random_radius = sqrt(randf()) * radius
	var x = center.x + random_radius * cos(random_angle)
	var y = center.y + random_radius * sin(random_angle)
	
	return Vector2(x, y)


func _on_spawn_enemies_timeout():
	spawn_enemy()
