class_name HealUpgrade extends Upgrade

func _init(name = "Heal", description = "Heal 25% of your Max Health"):
	self.name = name
	self.description = description

func apply(stats:PlayerStats):
	if stats.health < stats.max_health:
		stats.health += stats.max_health * 0.25
