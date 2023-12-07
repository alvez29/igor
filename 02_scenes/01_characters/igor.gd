extends CharacterBody2D

enum {IDLE, RUN, HURT, DEAD}

const LEVEL_LIMIT = 2160

var state
var anim
var new_anim
var can_shoot = true

var movement_speed:int = 500
var shooting_speed:float = 0.4
var projectile_speed:float = 10
var damage:float = 10
var health:float = 100
var max_health:float = 100

var projectile_scene = preload("res://02_scenes/02_objects/projectile.tscn")

@onready var screen_width = get_viewport_rect().size.x
@onready var screen_heigth = get_viewport_rect().size.y

signal player_shot
signal player_hit
signal end_game

func _ready():
	change_state(IDLE)
	#TODO: crear sistema de experiencia
	update_health_bar()

func _physics_process(delta):
	var motion = process_input(delta)
	move_and_slide()
	if can_shoot:
		shoot()
	process_animation()
	update_health_bar()

func _on_reload_timer_timeout():
	can_shoot = true

func _on_damage_timer_timeout():
	player_hit.emit()

func _on_hit_area_area_entered(area):
	if area.is_in_group("enemy_projectile"):
		player_shot.emit()
	if area.is_in_group("enemy") and $enemy_damage_timer.is_stopped():
		player_hit.emit()
		$enemy_damage_timer.start()

func _on_hit_area_area_exited(area):
	if area.is_in_group("enemy"):
		$enemy_damage_timer.stop()

func change_state(new_state):
	state = new_state
	match state:
		IDLE: 
			new_anim = "run"
		RUN:
			new_anim = "run"
		HURT:
			new_anim = "hurt"
			on_hurt()
		DEAD:
			on_dead()

func on_hurt():
	pass

func on_dead():
	pass
	
# region process functions

func process_input(delta):
	var up = Input.is_action_pressed("up")
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var down = Input.is_action_pressed("down")
	
	velocity.x = 0
	velocity.y = 0
	
	if up:
		velocity.y = -movement_speed
		change_state(RUN)
	if down:
		velocity.y = movement_speed
		change_state(RUN)
	if left:
		velocity.x = -movement_speed
		change_state(RUN)
	if right:
		velocity.x = movement_speed
		change_state(RUN)

func shoot():
	# TODO: calcular el enemigo más cerca puede ser un problema con muchos enemigos
	var closest_enemy = find_closest_enemy()
	var stage_node = get_parent()
	var projectile_instance = projectile_scene.instantiate()

	if closest_enemy != null:
		projectile_instance.position = position
		projectile_instance.initialize_to_closest_enemy(closest_enemy, projectile_speed)
		stage_node.add_child(projectile_instance)
	
	can_shoot = false
	
	$reload_timer.wait_time = shooting_speed
	$reload_timer.start()


# endregion

# region public functions

func take_damage(damage):
	self.health -= damage
	print("La vida de igor es:" + str(health))
	if health <= 0:
		end_game.emit()

# endregion

# region auxiliar functions

func find_closest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var closest_enemy = null
	var closest_distance = null
	
	for enemy in enemies:
		var distance = (enemy.position - position).length()
		
		if (closest_enemy == null and closest_distance == null or distance < closest_distance):
			closest_enemy = enemy
			closest_distance = distance
	
	return closest_enemy

func process_animation():
	if new_anim != anim:
		anim = new_anim
		$animation.play(anim)
		
func update_health_bar():
	$health_bar.max_value = max_health
	$health_bar.value = health

# endregion
