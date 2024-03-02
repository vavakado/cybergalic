extends Node

func camera_transition(node, property, fin_pos, duration):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(node, property, fin_pos, duration)
