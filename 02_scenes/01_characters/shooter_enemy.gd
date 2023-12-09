class_name ShooterEnemy extends SimpleEnemy

var can_shoot = true
var shooting_speed
var projectile_speed
var projectile_damage

var projectile_scene = preload("res://02_scenes/02_objects/enemy_projectile.tscn")

func _ready():
	change_state(RUN)
	set_up_timer()

func _physics_process(delta):
	follow_igor(delta)
	if can_shoot:
		shoot()
	process_animation()
	
func _on_reload_timer_timeout():
	can_shoot = true

func set_up_timer():
	$reload_timer.wait_time = shooting_speed

func shoot():
	var stage_node = get_parent()
	var projectile_instance = projectile_scene.instantiate()

	if igor_reference != null:
		projectile_instance.position = position
		projectile_instance.initialize(igor_reference, projectile_speed, projectile_damage)
		stage_node.add_child(projectile_instance)
		$reload_timer.start()
		can_shoot = false
		
func initialize_shooter_enemy(igor_reference, enemy_health, movement_speed, melee_damage, projectile_damage, shooting_speed, projectile_speed):
	self.igor_reference = igor_reference
	self.health = enemy_health
	self.movement_speed = movement_speed
	self.damage = melee_damage
	self.projectile_damage = projectile_damage
	self.shooting_speed = shooting_speed
	self.projectile_speed = projectile_speed
