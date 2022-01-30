extends CanvasLayer

export (NodePath) var button1
export (NodePath) var button2
export (NodePath) var button3
export (NodePath) var button4
export (NodePath) var player

onready var buttonNodes = [
	get_node(button1),
	get_node(button2),
	get_node(button3),
	get_node(button4)
]

onready var playerNode = get_node(player)
onready var arrowNodes = [
	get_node("Arrow1"),
	get_node("Arrow2"),
	get_node("Arrow3")
	]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_rotate_arrow()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if button1:
		$Label.text = String(get_node(button1).DisplayValue)
	if button2:
		$Label2.text = String(get_node(button2).DisplayValue)
	if button3:
		$Label3.text = String(get_node(button3).DisplayValue)
	if button4:
		$Label4.text = String(get_node(button4).DisplayValue)
	_rotate_arrow()


func _rotate_arrow():
	var dPos = [Vector2(0,0), Vector2(0,0), Vector2(0,0)]
	var angles = [0.0, 0.0, 0.0]
	
	for i in range(3):
		dPos[i] = buttonNodes[i].position - playerNode.position
		angles[i] = atan2(dPos[i].x, -dPos[i].y)
		arrowNodes[i].set_rotation(angles[i])
		arrowNodes[i].visible = !(buttonNodes[i].get_node("Visibility Notifier").is_on_screen())
