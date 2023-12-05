extends CharacterBody2D

enum {IDLE, RUN, HURT, DEAD}

const LEVEL_LIMIT = 2160

var state
var anim
var new_anim
var can_shoot = true
@export var movement_speed:int = 500
@export var shooting_speed:int = 600
@export var projectile_speed:int = 10
@export var damage:float = 10
@export var health:float = 100

var projectile_scene = preload("res://02_scenes/02_objects/projectile.tscn")

@onready var screen_width = get_viewport_rect().size.x
@onready var screen_heigth = get_viewport_rect().size.y

func _ready():
	change_state(IDLE)

func _physics_process(delta):
	var motion = process_input(delta)
	move_and_slide()
	if can_shoot:
		shoot()
	process_animation()

func _on_reload_timer_timeout():
	can_shoot = true

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
	
	
	# TODO: hacer el escenario redondo
	if position.x > LEVEL_LIMIT:
		position.x = LEVEL_LIMIT
	if position.y > LEVEL_LIMIT:
		position.y = LEVEL_LIMIT
	if position.x < 0:
		position.x = 0
	if position.y < 0:
		position.y = 0

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
		$reload_timer.start()

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

# endregion
