extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("draw"):
		var pencil = preload("res://Scenes/PencilTool.tscn").instance()
		add_child(pencil)


func _on_Button_pressed():
	print("you win the game :)")
	pass # Replace with function body.
