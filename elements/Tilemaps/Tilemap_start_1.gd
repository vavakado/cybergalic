extends Node2D


func _on_area_2d_body_entered(body):
	Events.move_camera.emit(global_position)
