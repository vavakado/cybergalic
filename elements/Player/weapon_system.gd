extends Node2D

@export var weaponScene1: PackedScene
@export var weaponScene2: PackedScene

var currentWeapon
var weaponNode


func _ready():
	equipWeapon(weaponScene1)

func _process(delta):
	pass

func _input(event):
	print(Globals.weapon_type)
	if Globals.weapon_type == Globals.weapontype.NONE:
		Globals.weapon_type = Globals.weapontype.PISTOL
		equipWeapon(weaponScene1)
	if Globals.weapon_type == Globals.weapontype.BLASTER:
		equipWeapon(weaponScene2)

func equipWeapon(weaponScene):
	if weaponNode != null:
		weaponNode.queue_free()

	weaponNode = weaponScene.instantiate()
	add_child(weaponNode)
	currentWeapon = weaponNode
	currentWeapon.position = $Pos2D.position

func fire():
	if weaponNode:
		weaponNode.shoot()
