extends RigidBody2D

var movement_direction: Vector2
var projectile_speed: float = 8

func _physics_process(delta):
	process_collisions()
	move_and_collide(projectile_speed * movement_direction)
	
	if position.x > 4000 or position.x < -4000 or position.y > 4000 or position.y < -4000:
		queue_free()

func initialize_to_closest_enemy(enemy, projectile_speed):
	movement_direction = (enemy.position - position).normalized()
	projectile_speed = projectile_speed

func process_collisions():
	for colliding_body in get_colliding_bodies():
		if colliding_body.is_in_group("enemy"):
			on_enemy_hit()

func on_enemy_hit():
	queue_free()
