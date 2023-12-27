class_name ReduceFrictionUpgrade extends Upgrade

func _init(name = "More friction", description = "Your slide value decrease and gain more friction"):
	self.name = name
	self.description = description

func apply(stats:PlayerStats):
	stats.friction += 500
