extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var numButtonPressed = 0
const BUTTON_NUM = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _buttonPressed(button_pressed):
	
	if button_pressed:
		numButtonPressed += 1
	else:
		if numButtonPressed  > 0:
			numButtonPressed -= 1
	if numButtonPressed == BUTTON_NUM:
		print("you win the game :)")
	print(numButtonPressed)
