extends Control


# Declare member variables here. Examples:
# var a = 2
var buttonEnable = false


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(2), "timeout")
	$TitleAnimation.play("Fade")
	yield(get_tree().create_timer(1), "timeout")
	buttonEnable = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	if buttonEnable:
		$TitleAnimation.play_backwards("Fade")
		$MusicAnimation.play("MusicFade")
		yield(get_tree().create_timer(4), "timeout")
		get_tree().change_scene("res://Scenes/Level.tscn")


func _on_QuitButton_pressed():
	if buttonEnable:
		get_tree().quit()
		pass # Replace with function body.



func _on_CreditsButton_pressed():
	if buttonEnable:
		get_tree().change_scene("res://Scenes/Controls.tscn")
	if buttonEnable:
		get_tree().change_scene("res://Scenes/Controls.tscn")

func _on_ControlButton_pressed():
	if buttonEnable:
		get_tree().change_scene("res://Scenes/Instructions.tscn")
