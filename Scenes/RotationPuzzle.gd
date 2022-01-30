extends Node2D

var GRID_SIZE = 3
var rng = RandomNumberGenerator.new()
var WINDOW_HEIGHT = 600

var imageState = [
	[0, 0, 0],
	[0, 0, 0],
	[0, 0, 0]
]

onready var imageNodes = [
	[get_node("TL"), get_node("TC"), get_node("TR")],
	[get_node("CL"), get_node("C"), get_node("CR")],
	[get_node("BL"), get_node("BC"), get_node("BR")]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for row in range(GRID_SIZE):
		for col in range(GRID_SIZE):
			var curNode = imageNodes[row][col]
			curNode.set_pivot_offset(curNode.rect_size/2)
			curNode.set_scale(WINDOW_HEIGHT * inverse(curNode.rect_size) / GRID_SIZE)
			curNode.set_global_position(Vector2(200*col-50, 200*row-50))
			imageState[row][col] = rng.randi_range(0, GRID_SIZE)
			#imageState[row][col] = 1
			curNode.set_rotation_degrees(90 * imageState[row][col])


func _on_piece_pressed(row, col):
	print(row, col)
	var curNode = imageNodes[row][col]
	
	imageState[row][col] += 1
	imageState[row][col] %= 4
	curNode.set_rotation_degrees(90 * imageState[row][col])
	if isWinner():
		winState()


func isWinner():
	for row in range(GRID_SIZE):
		for col in range(GRID_SIZE):
			if (imageState[row][col] != 0):
				return false
	return true


func winState():
	get_node("Win Message").visible = true


func inverse(v):
	return Vector2(1.0 / v.x, 1.0 / v.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
