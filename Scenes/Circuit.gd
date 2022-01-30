extends Node2D

var WAIT_TIME = 0.01

var INACTIVE = 0
var ACTIVE = 1
var SOLVED = 2

var elementStates = [
	[INACTIVE, INACTIVE],
	[INACTIVE, INACTIVE],
	[INACTIVE, INACTIVE],
	[INACTIVE, INACTIVE]
]

onready var elementNodes = [
	[get_node("Circle1"), get_node("Circle2")],
	[get_node("Triangle1"), get_node("Triangle2")],
	[get_node("Star1"), get_node("Star2")],
	[get_node("Lightning1"), get_node("Lightning2")]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_element_pressed(shape, id):
	var curNode = elementNodes[shape][id-1]
	curNode.timer.set_wait_time(WAIT_TIME)
	curNode.timer.start()
	
	# code for checking match
	if (_hasMatch(shape, id)):
		_connectElements((shape))
	else:
		curNode.activeTime = 100
		curNode.activeTimeIndicator.visible = true
		curNode.set_pressed(true)
		elementStates[shape][id-1] = ACTIVE


func _hasMatch(shape, id):
	pass


func _connectElements(shape):
	pass
