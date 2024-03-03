extends Sprite2D

@onready var animator = $Area2D/AnimationPlayer
@onready var body = get_tree().get_nodes_in_group("player")

func _on_shop_area_body_entered(body):
	body = get_tree().get_nodes_in_group("player")
	print("bobobobbo")
	animator.play("migalka")
	return true
	
func _on_shop_area_body_exited(body):
	if animator.is_playing():
		animator.stop()
	else:
		pass
