class_name Projectile extends RigidBody2D

var movement_direction: Vector2
var projectile_speed: float
var damage:float

func _physics_process(delta):
	move_and_collide(projectile_speed * movement_direction)
	
	if position.x > 4000 or position.x < -4000 or position.y > 4000 or position.y < -4000:
		queue_free()

func _on_hit_zone_area_entered(area):
	if area.is_in_group("enemy"):
		on_enemy_hit()

func initialize_to_closest_enemy(enemy, projectile_speed, damage):
	self.movement_direction = (enemy.position - position).normalized()
	self.projectile_speed = projectile_speed
	self.damage = damage

func on_enemy_hit():
	queue_free()
