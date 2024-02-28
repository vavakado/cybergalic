#extends Node2D
#
#const TILE_SCENE = preload("res://tilemap.tscn")
#var tileground = TILE_SCENE.instantiate()
#
#func _ready():
	#add_sibling(tileground)
#
#
#
#
#
#
#
#
#func gen():
	#var tileground = TILE_SCENE.instantiate()
	#tileground.global_position += Vector2(40, 0)
	#add_sibling(tileground)
	#10 - 29
#func _process(delta):
	#if $Player.global_position.x == tileground.global_position.x + 10 or $Player.global_position.x == tileground.global_position.x + 29:
		#gen()
