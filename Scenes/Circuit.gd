extends CanvasLayer

var WAIT_TIME = 0.01

var INACTIVE = 0
var ACTIVE = 1
var SOLVED = 2

var rng = RandomNumberGenerator.new()

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

var curActive = [-1, -1]

signal minigame_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	shuffleElements()

func _on_element_pressed(shape, id):
	if (_hasMatch(shape, id)):
		_connectElements((shape))
		if (hasWon()):
			winState()
	else:
		var curNode = elementNodes[shape][id-1]
		curNode.timer.set_wait_time(WAIT_TIME)
		curNode.timer.start()
		curNode.activeTime = 100
		curNode.activeTimeIndicator.visible = true
		curNode.set_pressed(true)
		elementStates[shape][id-1] = ACTIVE
		
		if curActive[0] != -1:
			curNode = elementNodes[curActive[0]][curActive[1]]
			curNode.activeTime = 0
			curNode.activeTimeIndicator.visible = false
			curNode.set_pressed(false)
			elementStates[curActive[0]][curActive[1]] = INACTIVE
			
		curActive = [shape, id-1]

func shuffleElements():
	rng.randomize()
	randomize()
	var offset = -202.5
	var pos = range(8)
	pos.shuffle()
	for shape in range(4):
		for id in range(2):
			var row = pos[shape*2 + id] / 4
			var col = pos[shape*2 + id] % 4
			var curNode = elementNodes[shape][id]
			curNode.set_global_position(Vector2(
				col * 256 + rng.randi_range(0, 134) + offset,
				row * 300 + rng.randi_range(0, 134) + offset
				))

func _hasMatch(shape, id):
	return elementStates[shape][id%2] == 1

func _connectElements(shape):
	for i in range(2):
		var curNode = elementNodes[shape][i]
		curNode.set_disabled(true)
		curNode.timer.stop()
		curNode.activeTime = 100
		curNode.activeTimeIndicator.visible = true
		
		elementStates[shape][i] = SOLVED
	
	curActive = [-1, -1]

func hasWon():
	for shape in range(4):
		if elementStates[shape][0] != SOLVED:
			return false
	return true

func winState():
	emit_signal("minigame_completed")
	get_node("Win Message").visible = true
