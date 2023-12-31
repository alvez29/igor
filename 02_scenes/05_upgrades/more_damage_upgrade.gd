class_name MoreDamageUpgrade extends Upgrade

func _init(name = "More damage", description = "Increase your damage"):
	self.name = name
	self.description = description

func apply(stats:PlayerStats):
	stats.damage += 20
	stats.projectile_scale = clamp(stats.projectile_scale + 0.4, 0.2, 4)
