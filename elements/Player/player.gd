extends CharacterBody2D


const SPEED = 160.0
const JUMP_VELOCITY = -400.0
var jump_count = 0
var target_scale := Vector2(1.0, 1.0)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var rayleft = $RayCastLeft
@onready var rayright = $RayCastRight
@onready var animation = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor() or jump_count == 1 or jump_count == 2:
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("W") and is_on_floor():
		jump_count = 1
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("W") and not is_on_floor() and jump_count == 1:
		jump_count = 2
		velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		jump_count = 0
	var direction = Input.get_axis("A", "D")
	velocity.x = direction * SPEED
	move_and_slide()
	if not is_on_floor():
		$AnimatedSprite2D.scale.y = remap(abs(velocity.y), 0, abs(JUMP_VELOCITY), 0.75, 1.75)
		$AnimatedSprite2D.scale.x = remap(abs(velocity.y), 0, abs(JUMP_VELOCITY), 1.25, 0.75)
	else:
		$AnimatedSprite2D.scale = Vector2(1,1)
		
	
	if direction < 0 or Vector2(get_global_mouse_position()) < global_position:
		animation.set_flip_h(true)
	if direction > 0 or Vector2(get_global_mouse_position()) > global_position:
		animation.set_flip_h(false)
	if direction == 0:
		animation.play("idle")
	elif direction and $weapon_system.equiped_weapon:
		animation.play("run_with_gun")
	else:
		animation.play("run")
	
	gui_ammo()
	look_w()
	click_fire()
	

func look_w():
	$weapon_system.equiped_weapon.look_at(get_global_mouse_position())
	
func click_fire():
	if Input.is_action_just_pressed("LMB"):
		$weapon_system.fire()

func gui_ammo():
	$weapon_system/GUI/Control/Label.text = str($weapon_system.equiped_weapon.ammo_mag, " / ", $weapon_system.equiped_weapon.ammo)

