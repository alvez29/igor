extends CharacterBody2D

enum {RUN, HURT, DEAD}
var state
var anim
var new_anim
var can_shoot = true

@export var igor_reference:Node2D
@export var movement_speed:int
@export var shooting_speed:int = 1
@export var health:float
@export var projectile_speed:float = 10

var projectile_scene = preload("res://02_scenes/02_objects/rogi_projectile.tscn")

signal enemy_hit

func _ready():
	change_state(RUN, 0)
	set_up_timer()

func _physics_process(delta):
	follow_igor(delta)
	if can_shoot:
		shoot()
	process_animation()

func _on_hit_area_area_entered(area):
	if area.is_in_group("projectile"):
		on_enemy_hit()
		
func _on_reload_timer_timeout():
	can_shoot = true

func initialize_rogi(igor_reference, health, movement_speed):
	self.igor_reference = igor_reference
	self.health = health
	self.movement_speed = movement_speed
			
func change_state(new_state, damage):
	state = new_state
	match state:
		RUN:
			new_anim = "run"
		HURT:
			new_anim = "hurt"
			on_hurt(damage)
		DEAD:
			on_dead()

func on_hurt(damage):
	#TODO: así es lo suficientemente escalable??
	health -= damage
	if health <= 0:
		change_state(DEAD, 0)

func on_dead():
	queue_free()
	
func on_enemy_hit():
	enemy_hit.emit(self)
	
func follow_igor(delta):
	if igor_reference != null:
		var igor_position = igor_reference.position
		var direction_vector = (igor_position - position).normalized()
		velocity = direction_vector * movement_speed
		
		move_and_slide()

func set_up_timer():
	$reload_timer.wait_time = shooting_speed

func shoot():
	var stage_node = get_parent()
	var projectile_instance = projectile_scene.instantiate()

	if igor_reference != null:
		projectile_instance.position = position
		projectile_instance.initialize(igor_reference, projectile_speed)
		stage_node.add_child(projectile_instance)
		can_shoot = false
		$reload_timer.start()
	
func process_animation():
	if new_anim != anim:
		anim = new_anim
		$animation.play(anim)

func take_damage(damage):
	change_state(HURT, damage)
