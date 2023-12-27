class_name MoreMovementSpeedUpgrade extends Upgrade

func _init(name = "Gotta go faster", description = "Increase 50% your movement speed"):
	self.name = name
	self.description = description

func apply(stats:PlayerStats):
	stats.movement_speed *= 1.35
	stats.accel *= 1.15
