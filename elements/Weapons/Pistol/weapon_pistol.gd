extends Node2D

@onready var sprite = $Sprite2D
@export var bullet_scene: PackedScene
@export var mili_sec = 1
@onready var shotimer = $Timer
@onready var reloadtimer = $ReloadTimer
var can_fire = true
var can_shoot = true
@export var ammo_mag = 7
@export var ammo = 30
@onready var mag_size = ammo_mag
var ncount = 0

func _process(delta):
	if global_rotation_degrees <= -90 or global_rotation_degrees >= 90:
		self.scale.y = -1
	else:
		self.scale.y = 1
	
	if ammo_mag == 0 and ncount == 0:
		ncount = 1
		can_shoot = false
		ammo_mag = 0
		reloadtimer.start()
func shoot():
	if can_shoot == true:
		if can_fire == true:
			$AnimationPlayer.play("pistol_shot")
			if $AnimationPlayer.is_playing():
				$AnimationPlayer.stop()
				$AnimationPlayer.play("pistol_shot")
			var bullet_ins = bullet_scene.instantiate()
			bullet_ins.global_transform = $Pos2D.global_transform
			bullet_ins.rotation = rotation
			get_tree().get_root().add_child(bullet_ins)
			can_fire = false
			shotimer.start()
			ammo_mag -= 1
		
func _on_timer_timeout():
	can_fire = true

func reload():
	print("reload")
	
	var ammo_n = mag_size - ammo_mag
	
	if ammo >= ammo_n:
		ammo -= ammo_n
		ammo_mag = mag_size
	else:
		ammo_mag += ammo
		ammo = 0

func _on_reload_timer_timeout():
	print("reloadtimer timeout")
	if ammo == 0 and ammo_mag == 0:
		can_fire = false
		can_shoot = false
	elif ammo_mag == 0:
		print("elif ammo_mag == 0")
		reload()
		can_shoot = true
		ncount = 0
