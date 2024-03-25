extends CharacterBody2D

const SPEED = 160.0
const JUMP_VELOCITY = -400.0
var jump_count = 0
var target_scale := Vector2(1.0, 1.0)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var run_count = 0

var shopopened = false
var in_shop_area = false
var animcount = 1

@onready var shopanim = $weapon_system/GUI/shopanim
@onready var Gui = preload("res://gui/gui.tscn")
@onready var Esprite = $Sprite2D
@onready var rayleft = $RayCastLeft
@onready var rayright = $RayCastRight
@onready var animation = $AnimatedSprite2D

@onready var tilemap_start_node = get_tree().get_nodes_in_group("start")

func _ready():
	Events.entered_E.connect(pressE)

func _physics_process(delta):
	var direction_y = Input.get_axis("W","S")
	var direction_x = Input.get_axis("A", "D")
	velocity.y = direction_y * SPEED
	velocity.x = direction_x * SPEED
	if direction_y !=0 and direction_x !=0:
		velocity.y = direction_y * SPEED/1.41421356237
		velocity.x = direction_x * SPEED/1.41421356237
	move_and_slide()
	#if not is_on_floor():
		#$AnimatedSprite2D.scale.y = remap(abs(velocity.y), 0, abs(JUMP_VELOCITY), 0.75, 1.75)
		#$AnimatedSprite2D.scale.x = remap(abs(velocity.y), 0, abs(JUMP_VELOCITY), 1.25, 0.75)
	#else:
		#$AnimatedSprite2D.scale = Vector2(1,1)
		
	if Vector2(get_global_mouse_position()) > global_position:
		animation.set_flip_h(false)
	if Vector2(get_global_mouse_position()) < global_position:
		animation.set_flip_h(true)
	if direction_x < 0:
		animation.set_flip_h(true)
	if direction_x > 0:
		animation.set_flip_h(false)
	
		
	if direction_x == 0 and direction_y == 0:
		animation.play("idle")
	else:
		animation.play("run")
	
	if Globals.shop_area_state == true and Input.is_action_just_pressed("bukva_e") and shopopened == false and animcount == 1:
		$weapon_system/GUI/ScrollContainer.show()
		$weapon_system/GUI/shopanim.play("shopanim")
		shopopened = true
		animcount = 2
	elif Globals.shop_area_state == false or Input.is_action_just_pressed("bukva_e") or Input.is_action_pressed("ui_cancel"):
		shopopened = false
		if !$weapon_system/GUI/shopanim.is_playing() or $weapon_system/GUI/shopanim.is_playing() or Globals.shop_area_state == false:
			if animcount == 2:
				$weapon_system/GUI/shopanim.play_backwards()
				animcount = 1
	
	gui_ammo()
	look_w()
	click_fire()
		
func look_w():
	$weapon_system.weaponNode.look_at(get_global_mouse_position())
	
func click_fire():
	if shopopened == false:
		if Input.is_action_pressed("LMB"):
			$weapon_system.fire()
			
func gui_ammo():
	$weapon_system/GUI/Control/MarginContainer/Label.text = str($weapon_system.weaponNode.ammo_mag, " / ", $weapon_system.weaponNode.ammo)
	
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
