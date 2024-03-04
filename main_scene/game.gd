extends Node2D

const Tilemap_start_1 = preload("res://elements/Tilemaps/Tilemap_start_1.tscn")
const Tilemap_corridor_1 = preload("res://elements/Tilemaps/Tilemap_corridor_1.tscn")
const Tilemap_corridor_2_up = preload("res://elements/Tilemaps/Tilemap_corridor_2_up.tscn")
const Tilemap_corridor_2_down = preload("res://elements/Tilemaps/Tilemap_corridor_2_down.tscn")
const Tilemap_corner_1_up = preload("res://elements/Tilemaps/Tilemap_corner_1_up.tscn")
const Tilemap_corner_1_down = preload("res://elements/Tilemaps/Tilemap_corner_1_down.tscn")
@onready var Camera = $Camera2D

func _ready():
	Events.move_camera.connect(move_cam)
	var map: Array[Array]
	for i in range(5):
		var be: Array
		for j in range(5):
			be.push_back(randi_range(0,5))
		map.push_back(be)
		
	var c = 0
	map[0][0] = 0
	var z = 0
	print(map)
	
	for i in map:
		for variant in i:
			if variant == 0:
				spawn_tile(Tilemap_start_1, z, c)
			elif variant == 1:
				spawn_tile(Tilemap_corridor_1, z, c)
			elif variant == 2:
				spawn_tile(Tilemap_corridor_2_up, z, c)
			elif variant == 3:
				spawn_tile(Tilemap_corridor_2_down, z, c)
			elif variant == 4:
				spawn_tile(Tilemap_corner_1_up, z, c)
			elif variant == 5:
				spawn_tile(Tilemap_corner_1_down, z, c)
			c += 1
		z += 1
		c = 0
func spawn_tile(variant, x, y):
	var tile = variant.instantiate()
	tile.global_position = Vector2(x*560, y*352)
	add_child(tile)
func move_cam(final_pos: Vector2):
	Globals.camera_transition(Camera, "global_position", final_pos, 0.5)
