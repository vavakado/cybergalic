extends Node2D

@onready var animator = $Shop/ShopArea/AnimationPlayer

func _on_area_2d_body_entered(body):
	Events.move_camera.emit(global_position)

func _on_shop_area_body_entered(body):
	animator.play("migalka")
	
func _on_shop_area_body_exited(body):
	if animator.is_playing():
		animator.stop()
