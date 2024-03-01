extends CharacterBody2D

const max_speed = 9600.0
const accel = 50
const friction = 70

const SPEED = 160.0
const JUMP_VELOCITY = -1000.0
const max_jumps = 1
var current_jumps = 0
signal new_tile(index: int)

var gravity = 4320.0

@onready var raycastleft = $RayCastLeft
@onready var raycastright = $RayCastRight
@onready var animation = $AnimatedSprite2D

func input() -> Vector2:
	var input_dir = Vector2.ZERO

	input_dir.x = Input.get_axis("A", "D")
	input_dir.y = Input.get_axis("S", "W")
	input_dir = input_dir.normalized()
	return input_dir
	
func player_movement():
	if Input.is_action_just_pressed("A"):
		animation.set_flip_h(true)
	if Input.is_action_just_pressed("D"):
		animation.set_flip_h(false)
	move_and_slide()

func jump(delta):
	if Input.is_action_just_pressed("W"):
		if current_jumps < max_jumps:
			velocity.y = JUMP_VELOCITY
			current_jumps += 1
	if is_on_floor():
		current_jumps = 0

func _physics_process(delta):
	velocity.y += gravity * delta
	var input_dir: Vector2 = input()

	if input_dir != Vector2.ZERO:
		velocity = velocity.move_toward(max_speed * input_dir * delta, accel)
		animation.play("run")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)
		animation.play("idle")
	jump(delta)
	

	if not is_on_floor():
		$AnimatedSprite2D.scale.y = remap(abs(velocity.y), 0, abs(JUMP_VELOCITY), 0.75, 1.75)
		$AnimatedSprite2D.scale.x = remap(abs(velocity.y), 0, abs(JUMP_VELOCITY), 1.25, 0.75)
	else:
		$AnimatedSprite2D.scale = Vector2(1,1)

	if raycastleft.is_colliding() or raycastright.is_colliding():
		new_tile.emit(floor(global_position.x/640)+1)
	player_movement()
