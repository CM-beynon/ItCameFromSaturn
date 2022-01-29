extends KinematicBody2D

# Constants
const SPEED = 200
const JUMP = -800
const GRAVITY = 30

# States
enum States {FLOOR, AIR}

# Variables
var state = States.FLOOR
var velocity = Vector2(0,0)

func _physics_process(delta):  
	print(velocity)
	
	move_left_or_right()
	if Input.is_action_pressed("ui_up"):
		velocity.y = JUMP
	else:
		velocity.y += 30
	move()
	"""
	match state:
		
		States.FLOOR:
			if !is_on_floor():
				state = States.AIR
				continue
			move_left_or_right()
			if Input.is_action_pressed("ui_up"):
				velocity.y = JUMP
				
			move()
			
			
		States.AIR:
			if is_on_floor():
				state = States.FLOOR
				continue
			move_left_or_right()
			velocity.y += 30
			move()
			"""

# Calculates movement and collisions from the velocity vector
func move():
	velocity = move_and_slide(velocity, Vector2.UP)
	
# Checks if the player is trying to move left or right
func move_left_or_right():
	if Input.is_action_pressed("ui_right"):
				velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		velocity.x = lerp(velocity.x, 0, 0.15)
