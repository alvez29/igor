class_name EnemyDamageTimer extends Timer

var enemy_damage:float

func set_enemy_damage(damage):
	self.enemy_damage = damage
	
func clear_enemy_damage():
	set_enemy_damage(float(0))
