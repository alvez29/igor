class_name SimpleEnemy extends CharacterBody2D

enum {RUN, HURT, DEAD}

var state
var anim
var new_anim

var player_reference
var movement_speed
var health
var damage

signal spawn_exp
signal enemy_hit

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
			on_dead()

func on_dead():
	call_deferred("emit_spawn_exp")
	queue_free()
	
func emit_spawn_exp():
	spawn_exp.emit(position)

func follow_igor(_delta):
	if player_reference != null:
		var player_position = player_reference.position
		var player_distance = player_position - position
		var direction_vector = player_distance.normalized()
		var player_distance_value = abs(player_distance.length())
		
		# this make player movement a bit more satisfactory since enemy 
		# will stop if its close enough to the player
		# even so, this is just a workaround preventing the implementation of a 
		# simulated pushing system in CharacterBody
		# CharacterBody let me get the movement I want but, since enemy is a CharacterBody and not a RigidBody,
		# player can't push enemies through pyhsics motor which is a mechanic that would immprove the player movement considerably
		
		if player_distance_value <= 92:
			velocity = Vector2(0, 0)
		else:
			velocity =  direction_vector * movement_speed
		
	move_and_slide()

func process_animation():
	if new_anim != anim:
		anim = new_anim
		$animation.play(anim)

func take_damage(enemy_damage):
	emit_signal("enemy_hit", self.position)
	change_state(HURT)
	health -= enemy_damage
	if health <= 0:
		change_state(DEAD)

func initialize_simple_enemy(player_reference, health, movement_speed, damage):
	self.player_reference = player_reference
	self.health = health
	self.movement_speed = movement_speed
	self.damage = damage

func _on_hurt_animation_timer_timeout():
	change_state(RUN)
