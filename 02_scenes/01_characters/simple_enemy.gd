class_name SimpleEnemy extends CharacterBody2D

enum {RUN, HURT, DEAD}
var state
var anim
var new_anim

var igor_reference
var movement_speed
var health

signal enemy_hit

func _ready():
	change_state(RUN, 0)

func _physics_process(delta):
	follow_igor(delta)
	process_animation()

func _on_hit_area_area_entered(area):
	if area.is_in_group("projectile"):
		on_enemy_hit()
			
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

func process_animation():
	if new_anim != anim:
		anim = new_anim
		$animation.play(anim)

func take_damage(damage):
	change_state(HURT, damage)

func initialize_simple_enemy(igor_reference, health, movement_speed):
	self.igor_reference = igor_reference
	self.health = health
	self.movement_speed = movement_speed
