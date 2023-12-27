class_name MoreMovementSpeedUpgrade extends Upgrade

func _init(name = "Gotta go faster", description = "Increase 10% your movement speed"):
	self.name = name
	self.description = description

func apply(stats:PlayerStats):
	stats.movement_speed *= 1.1
	stats.accel *= 1.1
