class_name EnemyProjectile extends RigidBody2D

var movement_direction:Vector2
var projectile_speed:float
var damage:float

func _physics_process(delta):
	move_and_collide(projectile_speed * movement_direction * delta)
	
	if position.x > 4000 or position.x < -4000 or position.y > 4000 or position.y < -4000:
		queue_free()

func _on_hit_area_area_entered(area):
	if area.get_parent() is Igor:
		on_player_hit()

func initialize(player, projectile_speed, damage):
	self.movement_direction = (player.position - position).normalized()
	self.projectile_speed = projectile_speed
	self.damage = damage

func on_player_hit():
	queue_free()
