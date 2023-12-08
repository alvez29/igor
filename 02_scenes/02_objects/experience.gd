class_name Experience extends RigidBody2D

const FLYING_SPEED = 400

var factor = 1

signal on_exp_collected

func _physics_process(delta):
	if $attraction_zone.has_overlapping_bodies():
		var players_in_area = $attraction_zone.get_overlapping_areas().filter(func (area): return area.get_parent() is Igor)
		
		if players_in_area.size() >= 1:
			var movement_direction = (players_in_area.front().get_parent().position - position).normalized()
			rotate(PI / 30)
			var collision = move_and_collide(movement_direction * FLYING_SPEED * delta)
			
			if collision:
				on_exp_collected.emit(factor)
				queue_free()
	else:
		linear_velocity = Vector2(0, 0)

func set_factor(new_factor):
	self.factor = new_factor
