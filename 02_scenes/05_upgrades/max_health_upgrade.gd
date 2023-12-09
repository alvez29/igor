class_name MaxHealthUpgrade extends Upgrade

func apply(stats:PlayerStats):
	var stats_copy = stats
	stats_copy.max_health = stats_copy.max_health * 1.4
	stats_copy.health = stats_copy.health * 1.4
	
	return stats_copy
