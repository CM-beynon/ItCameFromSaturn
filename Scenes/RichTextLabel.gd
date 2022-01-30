extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func add_text(text_to_add):
	text += text_to_add

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(1000, 9999)
	var message = str("Draw The Number: ", num)
	add_text(message)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
