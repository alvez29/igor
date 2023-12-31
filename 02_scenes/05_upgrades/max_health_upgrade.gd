class_name MaxHealthUpgrade extends Upgrade

func _init(name = "Get Healthier", description = "Increase 40% your max health"):
	self.name = name
	self.description = description

func apply(stats:PlayerStats):
	stats.max_health *= 1.4
	stats.health *= 1.4
	stats.player_scale = clamp(stats.player_scale + 0.2, 0.2, 6)
