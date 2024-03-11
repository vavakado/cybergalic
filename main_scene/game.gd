extends Node2D

const Tilemap_start_1 = preload("res://elements/Tilemaps/Tilemap_start_1.tscn")
const Tilemap_corridor_1 = preload("res://elements/Tilemaps/Tilemap_corridor_1.tscn")
const Tilemap_corridor_2_up = preload("res://elements/Tilemaps/Tilemap_corridor_2_up.tscn")
const Tilemap_corridor_2_down = preload("res://elements/Tilemaps/Tilemap_corridor_2_down.tscn")
const Tilemap_corner_1_up = preload("res://elements/Tilemaps/Tilemap_corner_1_up.tscn")
const Tilemap_corner_1_down = preload("res://elements/Tilemaps/Tilemap_corner_1_down.tscn")
const Tilemap_cross_1 = preload("res://elements/Tilemaps/Tilemap_cross_1.tscn")
const Tilemap_pipe_1 = preload("res://elements/Tilemaps/Tilemap_pipe_1.tscn")
@onready var Camera = $Camera2D
const right = [1,2,3,6,7,8]
const left = [0,1,2,3,4,5,8]
const up = [3,5,7,8,9,10]
var is_on_left
var is_on_right
var is_on_up
func _ready():
	#seed("ёп".hash())
	Events.move_camera.connect(move_cam)
	var map: Array[Array]
	for i in range(5):
		var be: Array
		for j in range(5):
			be.push_back(275)
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
			if map[selected_x][selected_y-1] in up:
				is_on_up = true
			if map[selected_x-1][selected_y] in left:
				is_on_left = true
			if selected_x != 4:
				if map[selected_x+1][selected_y] in right:
					is_on_right = true
			if is_on_left == true and is_on_right == true and is_on_up == true:
				map[selected_x][selected_y] = [2,8].pick_random()
			elif is_on_left == true and is_on_up == true:
				map[selected_x][selected_y] = [2,6,8].pick_random()
			elif is_on_left == true and is_on_right == true:
				map[selected_x][selected_y] = [1,3].pick_random()
			elif is_on_left == true:
				map[selected_x][selected_y] = [1,3,7].pick_random()
			elif is_on_up == true and is_on_right == true:
				map[selected_x][selected_y] = 4
			elif is_on_up == true:
				map[selected_x][selected_y] = 4
			else:
				map[selected_x][selected_y] = 5
		selected_x += 1
		is_on_left = false
		is_on_right = false
		is_on_up = false
		if selected_x == 5:
			add_enterances(map, selected_y)
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
			elif variant == 8:
				spawn_tile(Tilemap_cross_1, z, c)
			elif variant == 9:
				spawn_flipped_tile(Tilemap_pipe_1, z, c)
			elif variant == 10:
				spawn_tile(Tilemap_pipe_1, z, c)
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
	
func add_enterances(map, y):
	var row = []
	var no_down = true
	for x in range(5):
		row.push_back(map[x][y])
	for downie in up:
		if row.has(downie) and no_down == true:
			no_down = false
	if no_down == true and y != 4:
		var x
		if y == 2:
			x = [1,2,3,4].pick_random()
		else:
			x = range(5).pick_random()
		if map[x][y-1] in up:
			is_on_up = true
		if map[x-1][y] in left:
			is_on_left = true
		if x != 4:
			if map[x+1][y] in right:
				is_on_right = true
		if is_on_up == true:
			if is_on_left == true && is_on_right == true:
				map[x][y] = 8
			elif is_on_right == true:
				map[x][y] = 10 
			elif is_on_left == true:
				map[x][y] = [9,8].pick_random()
		else:
			if is_on_left == true && is_on_right == true:
				map[x][y] = 3
			if is_on_right:
				map[x][y] = 5
			if is_on_left:
				map[x][y] = [7, 3].pick_random()
