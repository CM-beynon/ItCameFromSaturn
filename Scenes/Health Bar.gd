extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var progress = 0
var inc = 0
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	progress = 30
	inc = 1
	timer.set_wait_time(0.1)
	timer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	progress += inc
	if progress >= 100:
		inc = -1
	if progress <= 0:
		inc = 1
	
	
