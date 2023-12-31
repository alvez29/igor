class_name UpgradeFactory

var availabe_stats_upgrades:Array = [
	HealUpgrade.new(),
	MaxHealthUpgrade.new(),
	MoreMovementSpeedUpgrade.new(),
	ReduceFrictionUpgrade.new(),
	MoreDamageUpgrade.new(),
	ShootFasterUpgrade.new(),
	LearnFasterUpgrade.new(),
]

func get_random_stat_upgrade():
	return availabe_stats_upgrades.pick_random()
