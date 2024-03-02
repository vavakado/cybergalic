extends Node2D

@onready var Camera = get_node("../Camera2D")

func _ready():
	pass # Replace with function body.
#Сделать так, чтобы от этой area поступал сигнал в gen() с аргументом: с какой стороны сам триггер(типа enum)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	print(Camera.global_position)

func _on_area_right_body_entered(body):
	Events.new_tile.emit(floor(global_position.x/656)+1,2)
	Globals.camera_transition(Camera, "global_position", global_position + Vector2(360, 280), 0.5)
	
