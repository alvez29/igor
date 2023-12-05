extends CharacterBody2D

enum {RUN, HURT, DEAD}
var state
var anim
var new_anim

@export var igor_reference:Node2D
@export var movement_speed:int = 300
@export var health:float = 50

signal enemy_hit

func _ready():
	change_state(RUN, 0)

func _physics_process(delta):
	process_collisions()
	follow_igor(delta)
	process_animation()

func _on_hit_area_area_entered(area):
	if area.is_in_group("projectile"):
		on_enemy_hit()
	
func initialize_rogi(igor_reference, health, movement_speed):
	self.igor_reference = igor_reference
	self.health = health
	self.movement_speed = movement_speed
	
func process_collisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		collision.is_queued_for_deletion()
		if collision.get_collider().name == "projectile":
			print(collision)
	
			
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

func on_dead():
	pass
	
func on_enemy_hit():
	print("enemy hit")
	enemy_hit.emit()
	
func follow_igor(delta):
	if igor_reference != null:
		var igor_position = igor_reference.position
		var direction_vector = (igor_position - position).normalized()
		velocity = direction_vector * movement_speed
		
		move_and_slide()

func process_animation():
	if new_anim != anim:
		anim = new_anim
		$animation.play(anim)


