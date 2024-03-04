extends Node

func camera_transition(node, property, fin_pos, duration):
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(node, property, fin_pos, duration)

var shop_area_state = false
