class_name MoreMovementSpeedUpgrade extends Upgrade

func _init(name = "Reduce friction", description = "Your slide value decrease 20%"):
	self.name = name
	self.description = description

func apply(stats:PlayerStats):
	stats.friction *= 0.5
