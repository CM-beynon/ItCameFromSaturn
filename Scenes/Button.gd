extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var DisplayValue = 9
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Button_body_entered(body):
	emit_signal("Body Entered")
	
func _pressed():
	timer.set_wait_time(1)
	timer.start()


func _on_Timer_timeout():
	if DisplayValue > 0:
		DisplayValue -= 1
