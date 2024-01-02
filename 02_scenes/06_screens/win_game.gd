class_name WinGame extends Control

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://02_scenes/03_levels/main_level.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
