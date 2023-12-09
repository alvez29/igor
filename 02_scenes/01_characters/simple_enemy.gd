class_name SimpleEnemy extends CharacterBody2D

enum {RUN, HURT, DEAD}
var state
var anim
var new_anim

var igor_reference
var movement_speed
var health
var damage

signal spawn_exp

func _ready():
	change_state(RUN)

func _physics_process(delta):
	follow_igor(delta)
	process_animation()

func _on_hit_area_area_entered(area):
	var area_parent = area.get_parent()
	
	if area_parent is Projectile:
		take_damage(area_parent.damage)
			
func change_state(new_state):
	state = new_state
	match state:
		RUN:
			new_anim = "run"
		HURT:
			new_anim = "hurt"
			$hurt_animation_timer.start()
		DEAD:
			new_anim = "dead"
			on_dead()
	

func on_dead():
	call_deferred("emit_spawn_exp")
	queue_free()
	
func emit_spawn_exp():
	spawn_exp.emit(position)

func follow_igor(_delta):
	if igor_reference != null:
		var igor_position = igor_reference.position
		var direction_vector = (igor_position - position).normalized()
		velocity = direction_vector * movement_speed
		
		move_and_slide()

func process_animation():
	if new_anim != anim:
		anim = new_anim
		$animation.play(anim)

func take_damage(enemy_damage):
	change_state(HURT)
	health -= enemy_damage
	if health <= 0:
		change_state(DEAD)

func initialize_simple_enemy(igor_reference, health, movement_speed, damage):
	self.igor_reference = igor_reference
	self.health = health
	self.movement_speed = movement_speed
	self.damage = damage


func _on_hurt_animation_timer_timeout():
	change_state(RUN)