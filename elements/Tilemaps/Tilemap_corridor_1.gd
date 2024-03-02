extends Node2D

@onready var Camera = get_node("../Camera2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_left_body_entered(body):
	Globals.camera_transition(Camera, "global_position", self.global_position + Vector2(-360, 280), 0.5)
	Events.new_tile.emit(floor(global_position.x/656)+1,1)
	

func _on_area_right_body_entered(body):
	Globals.camera_transition(Camera, "global_position", self.global_position + Vector2(360, 280), 0.5)
	Events.new_tile.emit(floor(global_position.x/656)+1,2)
	

