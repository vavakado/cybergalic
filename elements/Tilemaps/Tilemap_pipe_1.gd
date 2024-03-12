extends Node2D


func _on_area_2d_body_entered(body):
	if scale.x == 1:
		Events.move_camera.emit(global_position)
	else:
		Events.move_camera.emit(global_position-Vector2(560, 0))
