extends Line2D




func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_released("draw"):
		$Timer.stop()



func _on_Timer_timeout():
	add_point(get_global_mouse_position())
	$Timer.start()
