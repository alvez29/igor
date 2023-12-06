extends RigidBody2D

var movement_direction: Vector2
var projectile_speed: float

func _physics_process(delta):
	move_and_collide(projectile_speed * movement_direction)
	
	if position.x > 4000 or position.x < -4000 or position.y > 4000 or position.y < -4000:
		queue_free()

func _on_hit_area_area_entered(area):
	if area.is_in_group("player"):
		on_player_hit()

func initialize(player, projectile_speed):
	self.movement_direction = (player.position - position).normalized()
	self.projectile_speed = projectile_speed

func on_player_hit():
	queue_free()
