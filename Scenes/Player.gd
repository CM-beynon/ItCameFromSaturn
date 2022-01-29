extends KinematicBody2D

# Constants
const SPEED = 200
const JUMP = -800
const GRAVITY = 30

# States
enum States {FLOOR, AIR, CROUCH}

# Variables
var state = States.FLOOR
var velocity = Vector2(0,0)

	
func _physics_process(delta):  
	print(state)
	match state:
		
		States.FLOOR:
			$Sprite.scale.y = 1.5
			$CollisionShape2D.scale.y = 1.5
			
			move_left_or_right()
			if Input.is_action_pressed("ui_up"):
				velocity.y = JUMP
				
			move()
			
			if !is_on_floor():
				state = States.AIR
			if Input.is_action_pressed("ui_down"):
				state = States.CROUCH
			
		States.AIR:
			move_left_or_right()
			velocity.y += GRAVITY
			move()
			if is_on_floor() and !Input.is_action_pressed("ui_down"):
				state = States.FLOOR
			if is_on_floor() and Input.is_action_pressed("ui_down"):
				state = States.CROUCH
				
		States.CROUCH:
			$Sprite.scale.y = 0.99
			$CollisionShape2D.scale.y = 0.99
			move_left_or_right()
			move()
			if !is_on_floor():
				state = States.AIR
			if !$CheckCeilingLeft.is_colliding() and !$CheckCeilingRight.is_colliding() and !Input.is_action_pressed("ui_down"):
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
