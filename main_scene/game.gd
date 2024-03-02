extends Node2D

const Tilemap_start_1 = preload("res://elements/Tilemaps/Tilemap_start_1.tscn")
const Tilemap_corridor_2_up = preload("res://elements/Tilemaps/Tilemap_corridor_2_up.tscn")
const Tilemap_corridor_1 = preload("res://elements/Tilemaps/Tilemap_corridor_1.tscn")

@onready var Camera = $Camera2D

enum Collider {Left, Right, Up, Down}
enum Tiletype {Tilemap_start_1, Tilemap_corridor_2_up, Tilemap_corridor_1}

class tile_piece:
	var index: int
	var variant: Tiletype
	func _init(index, variant):
		self.index = index
		self.variant = variant
		
var spawned_tiles = [tile_piece.new(0, Tiletype.Tilemap_start_1)]

func _ready():
	var tileground = Tilemap_start_1.instantiate()
	Events.new_tile.connect(gen)
	add_child(tileground)
	
func check_array_for_index(arr, num):
	for item in arr:
		if item.index == num:
			return true
	return false

func gen(index: int, collider):
	print(index)
	if !check_array_for_index(spawned_tiles, index):
		if collider == 2:
			if [1, 2].pick_random() == 1:
				var tileground = Tilemap_corridor_1.instantiate()
				tileground.global_position += Vector2((index)*656, 0)
				add_child(tileground)
				spawned_tiles.append(tile_piece.new(index, Tiletype.Tilemap_corridor_1))
			else:
				var tileground = Tilemap_corridor_2_up.instantiate()
				tileground.global_position += Vector2((index)*656, 0)
				add_child(tileground)
				spawned_tiles.append(tile_piece.new(index, Tiletype.Tilemap_corridor_2_up))
		if collider == 1:
			if [1, 2].pick_random() == 1:
				var tileground = Tilemap_corridor_1.instantiate()
				tileground.global_position += Vector2((index)*656, 0)
				add_child(tileground)
				spawned_tiles.append(tile_piece.new(index, Tiletype.Tilemap_corridor_1))
			else:
				var tileground = Tilemap_corridor_2_up.instantiate()
				tileground.global_position += Vector2((index)*656, 0)
				add_child(tileground)
				spawned_tiles.append(tile_piece.new(index, Tiletype.Tilemap_corridor_2_up))



func _process(delta):
	pass
