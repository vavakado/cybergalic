extends CharacterBody2D


const SPEED = 160.0
const JUMP_VELOCITY = -500.0
var jump_count = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation = $AnimatedSprite2D

func _physics_process(delta):
	#if not is_on_floor():
		#velocity.y += gravity * delta
	#if Input.is_action_just_pressed("ui_up") and is_on_floor():
		#jump_count = 1
		#velocity.y = JUMP_VELOCITY
	if not is_on_floor() or jump_count == 1 or jump_count == 2:
		print("0")
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		print("1")
		jump_count = 1
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("ui_up") and not is_on_floor() and jump_count == 1:
		jump_count = 2
		velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		jump_count = 0
		
		
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	move_and_slide()
	
	if direction < 0:
		animation.set_flip_h(true)
	if direction > 0:
		animation.set_flip_h(false)
	if direction == 0:
		animation.play("idle")
	elif direction :
		animation.play("run")
