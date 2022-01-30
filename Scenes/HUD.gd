extends CanvasLayer

export (NodePath) var button1
export (NodePath) var button2
export (NodePath) var button3
export (NodePath) var button4
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if button1:
		var button1_instance = get_node(button1)
		if button1_instance.timer_cooldown == 3:
			$Label.text = String(button1_instance.DisplayValue)
		else:
			$Label.text = ""
	if button2:
		$Label2.text = String(get_node(button2).DisplayValue)
	if button3:
		$Label3.text = String(get_node(button3).DisplayValue)
	if button4:
		$Label4.text = String(get_node(button4).DisplayValue)
