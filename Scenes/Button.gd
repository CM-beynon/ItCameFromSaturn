extends Area2D

var can_press
var been_pressed = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_press:
		if Input.is_action_pressed("ui_accept"):
			been_pressed = true;
	if been_pressed:
		$Pressed.show()
		$Prompt.hide()

func _on_Button_body_entered(body):
	if !been_pressed:
		$Prompt.show()
	can_press = true


func _on_Button_body_exited(body):
	$Prompt.hide()
	can_press = false
