class_name Hud extends CanvasLayer

var upgrade_factory:UpgradeFactory = UpgradeFactory.new()

signal upgrade_selected

var first_upgrade:Upgrade
var second_upgrade:Upgrade
var third_upgrade:Upgrade

func update_exp(exp_value):
	$hud_control/exp_bar.value = exp_value

func update_time(time_in_seconds):
	var minutes = str(int(time_in_seconds / 60))
	var seconds = str(int(time_in_seconds % 60))
	
	if seconds.length() == 1:
		seconds = "0" + seconds
	
	$hud_control/time_left.text = minutes + ":" + seconds

func show_random_stats_upgrades():
	$hud_control/upgrades_container.hide()
	
	first_upgrade = upgrade_factory.get_random_stat_upgrade()
	second_upgrade = upgrade_factory.get_random_stat_upgrade()
	third_upgrade = upgrade_factory.get_random_stat_upgrade()
	
	$hud_control/upgrades_container/first_upgrade.text = first_upgrade.name
	$hud_control/upgrades_container/second_upgrade.text = second_upgrade.name
	$hud_control/upgrades_container/third_upgrade.text = third_upgrade.name
	
	$hud_control/upgrades_container.show()


func _on_first_upgrade_pressed():
	$hud_control/upgrades_container.hide()
	emit_signal("upgrade_selected", first_upgrade)

func _on_second_upgrade_pressed():
	$hud_control/upgrades_container.hide()
	emit_signal("upgrade_selected", second_upgrade)

func _on_third_upgrade_pressed():
	$hud_control/upgrades_container.hide()
	emit_signal("upgrade_selected", third_upgrade)
