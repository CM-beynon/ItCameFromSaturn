extends KinematicBody2D

onready var _animation_player = $AnimationPlayer

# Constants
const SPEED = 200
const JUMP = -800
const GRAVITY = 30

# States
enum States {FLOOR, AIR, CROUCH}

# Variables
var state = States.FLOOR
var velocity = Vector2(0,0)
var active_animation = false
var winTime = 60
var buttonsDone = 0

func _ready():
	$Survive.set_wait_time(1)
	$Survive.start()


	
func _physics_process(delta):
	
	if buttonsDone >= 3:
		get_tree().change_scene("res://Scenes/Death Scene.tscn")
	
	match state:
		States.FLOOR:
			$CollisionShape2D.scale.y = 1.5
			$CollisionShape2D.position.y = 16
			if velocity.length() > 1 and !active_animation:
				_animation_player.play("Walk")
			elif !active_animation:
				_animation_player.play("Idle")
				
			move_left_or_right()
			
			if Input.is_action_pressed("ui_up"):
				velocity.y = JUMP
				
			move()
			
			if !is_on_floor():
				state = States.AIR
			if Input.is_action_pressed("ui_down"):
				animate("Crouch")
				$Crunchy.play()
				state = States.CROUCH
			
		States.AIR:
			velocity.y += GRAVITY
			move_left_or_right()
			move()
			
			if is_on_floor() and !Input.is_action_pressed("ui_down") and !$CheckCeilingLeft.is_colliding() and !$CheckCeilingRight.is_colliding():
				state = States.FLOOR
			if is_on_floor() and Input.is_action_pressed("ui_down"):
				state = States.CROUCH
				
		States.CROUCH:
			$CollisionShape2D.scale.y = 0.99
			$CollisionShape2D.position.y = 32
			if velocity.length() > 1 and !active_animation:
				$AnimationPlayer.play("CrouchWalk")
			elif !active_animation: 
				$AnimationPlayer.play("CrouchIdle")
				
			move_left_or_right()
			move()
			
			if !is_on_floor():
				state = States.AIR
			if !$CheckCeilingLeft.is_colliding() and !$CheckCeilingRight.is_colliding() and !Input.is_action_pressed("ui_down"):
				animate("Stand")
				$Rebuild.play()
				state = States.FLOOR

func animate(animation):
	if !active_animation:
		_animation_player.play(animation)
		active_animation = true

# Calculates movement and collisions from the velocity vector
func move():
	velocity = move_and_slide(velocity, Vector2.UP)

# Checks if the player is trying to move left or right
func move_left_or_right():
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = true
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = false
		velocity.x = -SPEED
	else:
		velocity.x = lerp(velocity.x, 0, 0.15)

func _on_AnimationPlayer_animation_finished(anim_name):
	active_animation = false

func _on_Survive_timeout():
	winTime -= 1
	if winTime <= 0:
		winState()
		$Survive.stop()

func winState():
	get_tree().change_scene("res://Scenes/Win Screen.tscn")


func _on_Button_timer_done():
	buttonsDone += 1


func _on_Button_pressed_button(new_scene):
	buttonsDone -= 1
