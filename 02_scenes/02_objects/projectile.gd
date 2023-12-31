class_name Projectile extends RigidBody2D

var movement_direction:Vector2
var projectile_speed:float
var custom_scale:float
var damage:float

func _physics_process(delta):
	move_and_collide(projectile_speed * movement_direction * delta)
	self.scale = Vector2(custom_scale, custom_scale)
	
	if position.x > 4000 or position.x < -4000 or position.y > 4000 or position.y < -4000:
		queue_free()

func _on_hit_zone_area_entered(area):
	if area.get_parent() is SimpleEnemy:
		on_enemy_hit()

func initialize_to_closest_enemy(enemy, projectile_speed, damage, scale):
	self.movement_direction = (enemy.position - position).normalized()
	self.projectile_speed = projectile_speed
	self.damage = damage
	self.custom_scale = scale

func on_enemy_hit():
	queue_free()
