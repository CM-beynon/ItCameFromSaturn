extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = get_node("Timer")
onready var activeTimeIndicator = get_node("ActiveTimeIndicator")

var activeTime = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	activeTime = 0
	set_toggle_mode(true)


func _on_Timer_timeout(shape, id):
	activeTime -= 1
	if activeTime == 0:
		timer.stop()
		get_parent().elementStates[shape][id-1] = get_parent().INACTIVE
		activeTimeIndicator.visible = false
		set_pressed(false)
