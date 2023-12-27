class_name MaxHealthUpgrade extends Upgrade

func _init(name = "Get Healthier", description = "Increase your Max Health a 40%"):
	self.name = name
	self.description = description

func apply(stats:PlayerStats):
	stats.max_health *= 1.4
	stats.health *= 1.4
