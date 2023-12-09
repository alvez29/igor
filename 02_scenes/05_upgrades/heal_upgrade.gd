class_name HealUpgrade extends Upgrade

func apply(stats:PlayerStats):
	var stats_copy = stats
	stats_copy.health += stats_copy.max_health * 0.25
	
	return stats_copy
