class_name UpgradeFactory

var availabe_stats_upgrades:Array = [
	HealUpgrade.new(),
	MaxHealthUpgrade.new(),
	MoreMovementSpeedUpgrade.new(),
]

func get_random_stat_upgrade():
	return availabe_stats_upgrades.pick_random()
