extends Node2D

const Tilemap_start_1 = preload("res://elements/Tilemaps/Tilemap_start_1.tscn")
const Tilemap_corridor_2_up = preload("res://elements/Tilemaps/Tilemap_corridor_2_up.tscn")
const Tilemap_corridor_1 = preload("res://elements/Tilemaps/Tilemap_corridor_1.tscn")

@onready var Camera = $Camera2D

func _ready():
	randomize()
	var map: Array[Array]
	for i in range(5):
		var be: Array
		for j in range(5):
			be.push_back(randi_range(1,2))
		map.push_back(be)
		map[0][0] = 0
		
	var c = 0
	var z = 0
	
	for i in map:
		for k in i:
			if k == 0:
				var tile = Tilemap_start_1.instantiate()
				tile.global_position = Vector2(z*560, c*352)
				add_child(tile)
			elif k == 1:
				var tile = Tilemap_corridor_1.instantiate()
				tile.global_position = Vector2(z*560, c*352)
				add_child(tile)
			elif k == 2:
				var tile = Tilemap_corridor_2_up.instantiate()
				tile.global_position = Vector2(z*560, c*352)
				add_child(tile)
			c += 1
			print(c)
			print(z)
		z += 1
		c = 0
