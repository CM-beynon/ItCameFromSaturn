extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var AnimationN = $Control/AnimationPlayer
var scene:  String

func change_scene(new_scene,anim):
	scene = new_scene
	AnimationN.play(anim)

func _new_scene():
	get_tree().change_scene(scene)
