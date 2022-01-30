extends Area2D

export (PackedScene) var minigame
var minigame_instance

var can_press
var been_pressed = false
var timer_cooldown = 3

signal pressed_button(new_scene)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# export (int) var maxDisplayValue 
var DisplayValue = 30
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Display.text = String(DisplayValue)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_press:
		if Input.is_action_pressed("ui_accept"):
			pressed()
	if been_pressed:
		$Pressed.show()
		$Prompt.hide()
	else:
		$Display.show()	

func _on_Button_body_entered(body):
	if !been_pressed:
		$Prompt.show()
	can_press = true

func _on_Button_body_exited(body):
	$Prompt.hide()
	can_press = false
	
func pressed():
	if (minigame):
		minigame_instance = minigame.instance()
		get_tree().paused = true
		add_child(minigame_instance)
		minigame_instance.connect("minigame_completed", self, "_on_minigame_completion")
		$Timer.stop()
	else:
		reset_button()

func reset_button():
	$Timer.start()
	$Display.hide()
	been_pressed = true

func _on_Timer_timeout():
	if DisplayValue > 0:
		DisplayValue -= 1
	if !been_pressed:
		$Display.show()	
	else:
		if timer_cooldown > 0:
			timer_cooldown -= 1
		else:
			DisplayValue = 30
			$Display.show()
			$Pressed.hide()
			been_pressed = false
			timer_cooldown = 3
			

func _on_minigame_completion():
	remove_child(minigame_instance)
	get_tree().paused = false
	reset_button()
