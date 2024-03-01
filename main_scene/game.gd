extends Node2D

const TILE_SCENE = preload("res://tilemap.tscn")
const CORRIDOR_SCENE = preload("res://elements/Tilemaps/corridor.tscn")

class tile_piece:
	var index: int
	var variant: int
	func _init(index, variant):
		self.index = index
		self.variant = variant
		
var spawned_tiles = [tile_piece.new(0, 0)]

func _ready():
	var tileground = TILE_SCENE.instantiate()
	$Player.new_tile.connect(gen)
	add_child(tileground)
	
func check_array_for_index(arr, num):
	for item in arr:
		if item.index == num:
			return true
	return false

func gen(index: int):
	if !check_array_for_index(spawned_tiles, index):
		var tileground = CORRIDOR_SCENE.instantiate()
		tileground.global_position += Vector2((index)*640+16, 0)
		add_child(tileground)
		spawned_tiles.append(tile_piece.new(index, 0))
		
func _process(delta):
	pass
