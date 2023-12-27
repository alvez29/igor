extends CanvasLayer

func update_exp(exp_value):
	$hud_control/exp_bar.value = exp_value

func update_time(time_in_seconds):
	var minutes = str(int(time_in_seconds / 60))
	var seconds = str(int(time_in_seconds % 60))
	
	if seconds.length() == 1:
		seconds = "0" + seconds
	
	$hud_control/time_left.text = minutes + ":" + seconds
