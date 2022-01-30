extends Node2D


func _unhandled_key_input(event):
	if event.is_pressed():
		get_tree().change_scene("res://Scenes/StartMenu.tscn")
	if event is InputEventMouseButton:
		get_tree().change_scene("res://Scenes/StartMenu.tscn")
