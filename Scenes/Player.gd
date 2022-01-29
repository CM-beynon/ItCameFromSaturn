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
	
	match state:
		
		States.FLOOR:
			move_left_or_right()
			if Input.is_action_pressed("ui_up"):
				velocity.y = JUMP
				
			move()
			if !is_on_floor():
				state = States.AIR
			
		States.AIR:
			move_left_or_right()
			velocity.y += GRAVITY
			move()
			if is_on_floor():
				state = States.FLOOR

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
