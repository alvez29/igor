class_name ShootFasterUpgrade extends Upgrade


func _init(name = "Shoot faster", description = "Increase your shooting speed and bullet speed \n Decrease your damage"):
	self.name = name
	self.description = description

func apply(stats:PlayerStats):
	stats.shooting_speed *= 0.6
	stats.projectile_speed *= 1.2
	stats.damage *= 0.85
