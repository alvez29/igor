class_name Rogi extends Enemy

var can_shoot = true
var shooting_speed
var projectile_speed

var projectile_scene = preload("res://02_scenes/02_objects/rogi_projectile.tscn")

# TODO: realmente podría haber hecho esta clase hija de BigRogi y heredar el enemigo base y todo

func _ready():
	change_state(RUN, 0)
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
		projectile_instance.initialize(igor_reference, projectile_speed)
		stage_node.add_child(projectile_instance)
		can_shoot = false
		$reload_timer.start()
		
func initialize_rogi(igor_reference, enemy_health, movement_speed, shooting_speed, projectile_speed):
	self.igor_reference = igor_reference
	self.health = enemy_health
	self.movement_speed = movement_speed
	self.shooting_speed = shooting_speed
	self.projectile_speed = projectile_speed
