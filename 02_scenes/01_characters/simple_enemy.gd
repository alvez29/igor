class_name SimpleEnemy extends CharacterBody2D

enum {RUN, HURT, DEAD}
var state
var anim
var new_anim

var igor_reference
var movement_speed
var health
var damage

func _ready():
	change_state(RUN, 0)

func _physics_process(delta):
	follow_igor(delta)
	process_animation()

func _on_hit_area_area_entered(area):
	var area_parent = area.get_parent()
	
	if area.is_in_group("projectile") and area_parent is Projectile:
		take_damage(area_parent.damage)
			
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

func initialize_simple_enemy(igor_reference, health, movement_speed, damage):
	self.igor_reference = igor_reference
	self.health = health
	self.movement_speed = movement_speed
	self.damage = damage
