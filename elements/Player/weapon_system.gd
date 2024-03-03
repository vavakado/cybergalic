extends Node2D

@export var StartWeapon: PackedScene
var equiped_weapon : Node2D

func _ready():
	var SW_ins = StartWeapon.instantiate()
	if StartWeapon:
		ewp(SW_ins)

func ewp(etpw):
	if equiped_weapon:
		equiped_weapon.queue_free()
	else:
		equiped_weapon = etpw
		$Pos2D.add_child(equiped_weapon)

func fire():
	if equiped_weapon:
		equiped_weapon.shoot()
