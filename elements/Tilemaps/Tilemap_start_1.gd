extends Node2D

var state = false
@onready var player = preload("res://elements/Player/player.tscn")
@onready var animator = $Shop/ShopArea/AnimationPlayer

func _on_area_2d_body_entered(body):
	Events.move_camera.emit(global_position)

func _on_shop_area_body_entered(body):
	animator.play("migalka")
	Events.entered_E.emit(true)
	Globals.shop_area_state = true
	
func _on_shop_area_body_exited(body):
	if animator.is_playing():
		animator.stop()
	Events.entered_E.emit(false)
