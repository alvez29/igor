class_name Igor extends CharacterBody2D

enum {IDLE, RUN, HURT, DEAD}

const LEVEL_LIMIT = 2160

var state
var anim
var new_anim
var can_shoot = true

var stats:PlayerStats

var projectile_scene = preload("res://02_scenes/02_objects/projectile.tscn")

@onready var screen_width = get_viewport_rect().size.x
@onready var screen_heigth = get_viewport_rect().size.y

signal end_game

func _ready():
	change_state(IDLE)
	stats = PlayerStats.new()
	update_health_bar()

func _physics_process(delta):
	process_input(delta)
	move_and_slide()
	process_animation()
	update_health_bar()
	if can_shoot:
		shoot()

func _on_reload_timer_timeout():
	can_shoot = true

func _on_damage_timer_timeout():
	take_damage($enemy_damage_timer.enemy_damage)

func _on_hit_area_area_entered(area):
	var area_parent = area.get_parent()
	
	if area_parent is EnemyProjectile:
		take_damage(area_parent.damage)
	if area_parent is SimpleEnemy and $enemy_damage_timer.is_stopped():
		var enemy_damage = area_parent.damage
		
		take_damage(enemy_damage)
		$enemy_damage_timer.set_enemy_damage(enemy_damage)
		$enemy_damage_timer.start()

func _on_hit_area_area_exited(area):
	if area.get_parent() is SimpleEnemy:
		$enemy_damage_timer.clear_enemy_damage()
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
	var up = Input.is_action_pressed("up")
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var down = Input.is_action_pressed("down")
	
	velocity.x = 0
	velocity.y = 0
	
	if up:
		velocity.y = -stats.movement_speed
		change_state(RUN)
	if down:
		velocity.y = stats.movement_speed
		change_state(RUN)
	if left:
		velocity.x = -stats.movement_speed
		change_state(RUN)
	if right:
		velocity.x = stats.movement_speed
		change_state(RUN)

func process_input(delta):
	var input = Vector2.ZERO
	
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	input = input.normalized()
	
	if input == Vector2.ZERO:
		if velocity.length() > stats.friction * delta:
			velocity -= velocity.normalized() * stats.friction * delta
		else:
			velocity = Vector2.ZERO
	else:
		velocity += input * stats.accel * delta
		velocity = velocity.limit_length(stats.movement_speed)
		
func shoot():
	var closest_enemy = find_closest_enemy()
	var stage_node = get_parent()
	var projectile_instance = projectile_scene.instantiate()

	if closest_enemy != null:
		projectile_instance.position = position
		projectile_instance.initialize_to_closest_enemy(closest_enemy, stats.projectile_speed, stats.damage, stats.projectile_scale)
		stage_node.add_child(projectile_instance)
		$shoot_audio_player.play()
		can_shoot = false
	
	$reload_timer.wait_time = stats.shooting_speed
	$reload_timer.start()
	
# endregion

# region public functions

func take_damage(damage):
	stats.health -= damage
	print("igor's health: " + str(stats.health))
	if stats.health <= 0:
		end_game.emit()

# endregion

# region auxiliar functions

func process_upgrade(upgrade:Upgrade):
	upgrade.apply(stats)
	self.scale = Vector2(stats.player_scale, stats.player_scale)

func find_closest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var closest_enemy = null
	var closest_distance = null
	
	for enemy in enemies:
		var distance = distance_between(position, enemy.position)
		
		if closest_enemy == null and closest_distance == null or distance < closest_distance:
			closest_enemy = enemy
			closest_distance = distance
	
	return closest_enemy

func process_animation():
	if new_anim != anim:
		anim = new_anim
		$animation.play(anim)
		
func update_health_bar():
	$health_bar.max_value = stats.max_health
	$health_bar.value = stats.health

func distance_between(first_position, second_position):
	return (second_position.x - first_position.x)**2 + (second_position.y - first_position.y)**2

# endregion
