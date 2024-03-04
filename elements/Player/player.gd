extends CharacterBody2D

const SPEED = 160.0
const JUMP_VELOCITY = -400.0
var jump_count = 0
var target_scale := Vector2(1.0, 1.0)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var shopopened = false
var in_shop_area = false

@onready var Gui = preload("res://gui/gui.tscn")
@onready var Esprite = $Sprite2D
@onready var rayleft = $RayCastLeft
@onready var rayright = $RayCastRight
@onready var animation = $AnimatedSprite2D

@onready var tilemap_start_node = get_tree().get_nodes_in_group("start")

func _ready():
	Events.entered_E.connect(pressE)

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
	
	if Globals.shop_area_state == true and Input.is_action_just_pressed("bukva_e") and shopopened == false:
		$weapon_system/GUI/ScrollContainer.show()
		$weapon_system/GUI/shopanim.play("shopanim")
		shopopened = true
	elif Globals.shop_area_state == false or Input.is_action_just_pressed("bukva_e") or Input.is_action_pressed("ui_cancel"):
		#$weapon_system/GUI/ScrollContainer.hide()
		if !$weapon_system/GUI/shopanim.is_playing() or $weapon_system/GUI/shopanim.is_playing():
			$weapon_system/GUI/shopanim.play_backwards()
		shopopened = false

	gui_ammo()
	look_w()
	click_fire()
	
func look_w():
	$weapon_system.equiped_weapon.look_at(get_global_mouse_position())
	
func click_fire():
	if shopopened == false:
		if Input.is_action_pressed("LMB"):
			$weapon_system.fire()
func gui_ammo():
	$weapon_system/GUI/Control/MarginContainer/Label.text = str($weapon_system.equiped_weapon.ammo_mag, " / ", $weapon_system.equiped_weapon.ammo)
	
func pressE(state):
	print(state)
	if state == true:
		in_shop_area = true
		Globals.shop_area_state = true
		Esprite.show()
	if state == false:
		in_shop_area = false
		Globals.shop_area_state = false
		Esprite.hide()
