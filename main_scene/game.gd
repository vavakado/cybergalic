extends Node2D

const Tilemap_start_1 = preload("res://elements/Tilemaps/Tilemap_start_1.tscn")
const Tilemap_corridor_1 = preload("res://elements/Tilemaps/Tilemap_corridor_1.tscn")
const Tilemap_corridor_2_up = preload("res://elements/Tilemaps/Tilemap_corridor_2_up.tscn")
const Tilemap_corridor_2_down = preload("res://elements/Tilemaps/Tilemap_corridor_2_down.tscn")
const Tilemap_corner_1_up = preload("res://elements/Tilemaps/Tilemap_corner_1_up.tscn")
const Tilemap_corner_1_down = preload("res://elements/Tilemaps/Tilemap_corner_1_down.tscn")
@onready var Camera = $Camera2D
const right = [0,1,2,3,4,5]
const left = [1,2,3,6,7]
const up = [3,5,7]
func _ready():
	Events.move_camera.connect(move_cam)
	var map: Array[Array]
	for i in range(5):
		var be: Array
		for j in range(5):
			be.push_back(257)
		map.push_back(be)
		
	var c = 0
	map[0][2] = 0
	var selected_x = 0
	var selected_y = 0
	while selected_y != 5:
		map[0][2] = 0
		if (selected_x == 0 and selected_y == 0):
			map[selected_x][selected_y] = 5
		elif (selected_x == 0 and selected_y == 4):
			map[selected_x][selected_y] = 4
		elif (selected_x == 4 and selected_y == 4):
			map[selected_x][selected_y] = 6
		elif (selected_x == 4 and selected_y == 0):
			map[selected_x][selected_y] = 7
		else:
			if selected_y >= 1:
				if map[selected_x][selected_y-1] in up:
					if selected_x > 4:
						if map[selected_x+1][selected_y] in left:
							if map[selected_x-1][selected_y] in right:
								map[selected_x][selected_y] = [3].pick_random()
							else:
								map[selected_x][selected_y] = [3, 5].pick_random()
					else:
						if map[selected_x-1][selected_y] in right:
							map[selected_x][selected_y] = [4, 6].pick_random()
			if selected_x >= 0:
				if selected_x < 4:
					if map[selected_x+1][selected_y] in left:
						if map[selected_x-1][selected_y] in right:
							map[selected_x][selected_y] = [1,3].pick_random()
						else:
							map[selected_x][selected_y] = [0,7].pick_random()
					else:
						if map[selected_x-1][selected_y] in right:
							if selected_y == 0:
								map[selected_x][selected_y] = [1,3,7].pick_random()
							else:
								map[selected_x][selected_y] = [1,2,3,6,7].pick_random()
						else:
							map[selected_x][selected_y] = [4,5].pick_random()
				else:
					if map[selected_x-1][selected_y] in right:
						map[selected_x][selected_y] = [1,3,7].pick_random()
					else:
						map[selected_x][selected_y] = [4,5].pick_random()
		selected_x += 1
		if selected_x == 5:
			selected_y += 1
			selected_x = 0
	map[0][2] = 0
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
			elif variant == 6:
				spawn_flipped_tile(Tilemap_corner_1_up, z, c)
			elif variant == 7:
				spawn_flipped_tile(Tilemap_corner_1_down, z, c)
			c += 1
		z += 1
		c = 0
func spawn_tile(variant, x, y):
	var tile = variant.instantiate()
	tile.global_position = Vector2(x*560, y*352)
	add_child(tile)
func spawn_flipped_tile(variant, x, y):
	var tile = variant.instantiate()
	tile.global_position = Vector2(x*560, y*352)
	tile.scale.x = -1
	tile.global_position += Vector2(560, 0)
	add_child(tile)
func move_cam(final_pos: Vector2):
	Globals.camera_transition(Camera, "global_position", final_pos, 0.5)
