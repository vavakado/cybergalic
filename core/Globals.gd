extends Node

func camera_transition(node, property, fin_pos, duration):
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(node, property, fin_pos, duration)

enum weapontype {NONE, PISTOL, BLASTER}
var weapon_type = weapontype.NONE

var shop_area_state = false
var shoot = false
