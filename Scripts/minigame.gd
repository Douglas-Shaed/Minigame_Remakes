extends TileMapLayer

@onready var items_generated = $"../# of Items"
@onready var Items_Found = $"../Found"
@onready var Chisel_Button = $"../Chisel_Button"
@onready var Hammer_Button = $"../Hammer_Button"
@onready var Health_Layer = $"../Health"

const CELLS = {
	-1: Vector2i(0,22),
	0: Vector2i(7,22),
	1: Vector2i(1,22),
	2: Vector2i(2,22),
	3: Vector2i(3,22),
	4: Vector2i(4,22),
	5: Vector2i(5,22),
	6: Vector2i(6,22)
}

const HEALTH_BAR = {
	0:  Vector2i(0,0),
	1:  Vector2i(0,1),
	2:  Vector2i(0,2),
	3:  Vector2i(0,3),
	4:  Vector2i(0,4),
	5:  Vector2i(0,5),
	6:  Vector2i(0,6),
	7:  Vector2i(0,7),
	8:  Vector2i(0,8),
	9:  Vector2i(0,9),
	10: Vector2i(0,10),
	11: Vector2i(0,11),
	12: Vector2i(0,12),
	13: Vector2i(0,13),
	14: Vector2i(0,14),
	15: Vector2i(0,15)
}

const item_list = { #Index : Name, Atlas Location, Shape Array, Rotation
	1:  ["Red Shard", 		Vector2i(27,15), 	[[1,1,1],[1,1,0],[1,1,1]],	0],
	2:  ["Blue Shard", 		Vector2i(20,15), 	[[1,1,1],[1,1,1],[1,1,0]],	0],
	3:  ["Green Shard", 	Vector2i(23,15), 	[[1,1,1,1],[1,1,1,1],[1,1,0,1]],	0],
	4:  ["Yellow Shard", 	Vector2i(30,15), 	[[1,0,1,0],[1,1,1,0],[1,1,1,1]],	0],
	5:  ["Red Sphere S", 	Vector2i(23,12), 	[[1,1],[1,1]],	0],
	6:  ["Blue Sphere S", 	Vector2i(3,12), 	[[1,1],[1,1]],	0],
	7:  ["Green Sphere S", 	Vector2i(8,12), 	[[1,1],[1,1]],	0],
	8:  ["Pale Sphere S", 	Vector2i(13,12), 	[[1,1],[1,1]],	0],
	9:  ["Prism Sphere S", 	Vector2i(18,12),	[[1,1],[1,1]],	0],
	10: ["Red Sphere L", 	Vector2i(20,12), 	[[1,1,1],[1,1,1],[1,1,1]],	0],
	11: ["Blue Sphere L", 	Vector2i(0,12), 	[[1,1,1],[1,1,1],[1,1,1]],	0],
	12: ["Green Sphere L", 	Vector2i(5,12), 	[[1,1,1],[1,1,1],[1,1,1]],	0],
	13: ["Pale Sphere L", 	Vector2i(10,12), 	[[1,1,1],[1,1,1],[1,1,1]],	0],
	14: ["Prism Sphere L", 	Vector2i(15,12), 	[[1,1,1],[1,1,1],[1,1,1]],	0],
	15: ["Rare Bone", 		Vector2i(31,12),	[[1,0,0,0,0,1],[1,1,1,1,1,1],[1,0,0,0,0,1]] ,	1],
	16: ["Star Piece", 		Vector2i(32,9), 	[[0,1,0],[1,1,1],[0,1,0]],	0],
	17: ["Iron Ball", 		Vector2i(8,18), 	[[1,1,1],[1,1,1],[1,1,1]],	0],
	18: ["Light Clay", 		Vector2i(11,18), 	[[1,0,1,0],[1,1,1,0],[1,1,1,1],[0,1,0,1]],	0],
	19: ["Hard Stone", 		Vector2i(4,19), 	[[1,1],[1,1]],	0],
	20: ["Smooth Rock", 	Vector2i(26,18), 	[[0,0,1,0],[1,1,1,0],[0,1,1,1],[0,1,0,0]],	0],
	21: ["Heat Rock", 		Vector2i(18,18), 	[[1,0,1,0],[1,1,1,1],[1,1,1,1]],	0],
	22: ["Damp Rock", 		Vector2i(15,18), 	[[1,1,1],[1,1,1],[1,0,1]],	0],
	23: ["Icy Rock", 		Vector2i(22,18), 	[[0,1,1,0],[1,1,1,1],[1,1,1,1],[1,0,0,1]],	0],
	24: ["Everstone", 		Vector2i(0,19), 	[[1,1,1,1,],[1,1,1,1]],	0],
	25: ["Heart Scale", 	Vector2i(6,19), 	[[1,0],[1,1]],	0],
	26: ["Revive", 			Vector2i(28,12), 	[[0,1,0],[1,1,1],[0,1,0]],	0],
	27: ["Max Revive", 		Vector2i(25,12), 	[[1,1,1],[1,1,1],[1,1,1]],	0],
	28: ["Thunder Stone", 	Vector2i(9,15), 	[[0,1,1],[1,1,1],[1,1,0]],	0],
	29: ["Leaf Stone", 		Vector2i(3,15), 	[[0,1,0],[1,1,1],[1,1,1],[0,1,0]],	1],
	30: ["Moon Stone", 		Vector2i(15,15), 	[[0,1,1,1],[1,1,1,0]],	1],
	31: ["Sun Stone", 		Vector2i(6,15), 	[[0,1,0],[1,1,1],[1,1,1]],	0],
	32: ["Fire Stone", 		Vector2i(0,15), 	[[1,1,1],[1,1,1],[1,1,1]],	0],
	33: ["Water Stone", 	Vector2i(12,15), 	[[1,1,1],[1,1,1],[1,1,0]],	0],
	34: ["Helix Fossil", 	Vector2i(14,0),		[[0,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,0]],	3],
	35: ["Dome Fossil", 	Vector2i(9,0),		[[1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1],[0,1,1,1,0]],	0],
	36: ["Old Amber", 		Vector2i(22,0),		[[0,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,0]],	1],
	37: ["Root Fossil", 	Vector2i(26,0), 	[[1,1,1,1,0],[1,1,1,1,1],[1,1,0,1,1],[0,0,0,1,1],[0,0,1,1,0]],	3],
	38: ["Claw Fossil", 	Vector2i(5,0), 		[[0,0,1,1,],[0,1,1,1],[0,1,1,1],[1,1,1,0],[1,1,0,0]],	3],
	39: ["Armor Fossil", 	Vector2i(0,0), 		[[0,1,1,1,0],[0,1,1,1,0],[1,1,1,1,1],[0,1,1,1,0]],	0],
	40: ["Skull Fossil", 	Vector2i(31,0), 	[[1,1,1,1],[1,1,1,1],[1,1,1,1],[0,1,1,0]],	0],
	41: ["Odd Keystone", 	Vector2i(18,0),	[	[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]],	0],
	42: ["Draco Plate", 	Vector2i(0,6), 		[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	43: ["Dread Plate", 	Vector2i(4,6), 		[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	44: ["Earth Plate", 	Vector2i(8,6), 		[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	45: ["Fist Plate", 		Vector2i(12,6), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	46: ["Flame Plate", 	Vector2i(16,6), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	47: ["Icicle Plate", 	Vector2i(20,6), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	48: ["Insect Plate", 	Vector2i(24,6), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	49: ["Iron Plate", 		Vector2i(28,6), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	50: ["Meadow Plate", 	Vector2i(32,6), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	51: ["Mind Plate", 		Vector2i(0,9), 		[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	52: ["Sky Plate", 		Vector2i(4,9), 		[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	53: ["Splash Plate", 	Vector2i(8,9), 		[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	54: ["Spooky Plate", 	Vector2i(12,9), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	55: ["Stone Plate", 	Vector2i(16,9), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	56: ["Toxic Plate", 	Vector2i(20,9), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	57: ["Zap Plate", 		Vector2i(24,9), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0],
	58: ["Pixie Plate", 	Vector2i(28,9), 	[[1,1,1,1], [1,1,1,1], [1,1,1,1]],	0]
}

@export var columns = 13
@export var rows = 10
var Health = 49
var number_of_items = 0
var True_Found = 0

var map_arr = []

const CELL_TILE_SET_ID = 1

var cells_with_items = []
var item_storage = []
var check_list = []
var rotated_items = []
var rotate = 0



func _ready():
	Items_Found.text = str(True_Found)
	Chisel_Button.disabled = true
	Chisel_Button.pressed.connect(_button_pressed)
	Hammer_Button.pressed.connect(_button_pressed)
	
	clear()
	Health_Layer.set_cell(Vector2i(0,-1), 0, HEALTH_BAR[0])
	
	#map generation yay
	map_generation()
	while map_arr.count(2) < 15 || map_arr.count(4) < 30:
		clear()
		map_generation()
	
	place_items()

func map_generation(): # GOTTA FIGURE THIS OUT - MAKE FAIR MAP GENERATION
	var noise = FastNoiseLite.new()
	map_arr = []
	noise.seed = randi_range(0,4096)
	for i in columns:
		for j in rows:
			var cell_coord = Vector2i(i,j)
			var noise_value = noise.get_noise_2d(i,j)
			if noise_value <= 0.0:
				set_tile_cell(cell_coord, 2)
				map_arr.append(2)
			if noise_value > 0.0 && noise_value < 0.12:
				set_tile_cell(cell_coord, 4)
				map_arr.append(4)
			if noise_value >= 0.12:
				set_tile_cell(cell_coord, 6)
				map_arr.append(6)

func place_items():
	number_of_items = randi_range(2,4)
	items_generated.text = "/" + str(number_of_items)
	
	for i in number_of_items:
		var cell_coordinates = Vector2i(randi_range(0,12), randi_range(0, 9))
		rotate = 0
			
		var item = item_list[random_items()]
		
		if item[3] != 0:
			rotate = randi_range(0, item[3])
		rotated_items.append(rotate)
		
		while Overlap(cell_coordinates, item) || Out_of_Bounds(cell_coordinates, item):
			cell_coordinates = Vector2i(randi_range(0,12), randi_range(0,9))
			
		stuff(cell_coordinates, item)

func random_items():
	var random = RandomNumberGenerator.new()
	var random_item
	
	#Groups: Shards, Items, Stones, Fossils, Plates
	var Groups = ["Shards", "Items", "Stones", "Fossils", "Plates"]
	#Rarities: Common, UnCommon, Rare, Epic, Legendary
	var Rarities = [1,.5,.25,.125,.0625]
	
	var storage
	storage = Groups[random.rand_weighted(Rarities)]
	if storage == "Shards":
		random_item = randi_range(1,14)
	elif storage == "Items":
		random_item = randi_range(15,27)
	elif storage == "Stones":
		random_item = randi_range(28,33)
	elif storage == "Fossils":
		random_item = randi_range(34,41)
	elif storage == "Plates":
		random_item = randi_range(42,58)
	else: print("Error")
	
	return random_item

func Overlap(value, item):
	var overlap_array = []
	var item_x = item[2][0].size()
	var item_y = item[2].size()
	
	if rotate == 1 or rotate == 3:
		item_x = item[2].size()
		item_y = item[2][0].size()
	
	for each in item_storage:
		for piece in each:
			var ol_y = value.y
			for i in range(item_y):
				var ol_x = value.x
				for j in range(item_x):
					if piece[0] == Vector2i(ol_x ,ol_y):
						overlap_array.append(true)
					else: 
						overlap_array.append(false)
					ol_x = ol_x + 1
				ol_y = ol_y + 1
		
	if overlap_array.has(true):
		return true
	else : return false

func Out_of_Bounds(value, item):
	var min_x = 0
	var max_x = 12
	var min_y = 0
	var max_y = 9
	
	var item_x = item[2][0].size()
	var item_y = item[2].size()
	
	
	var oob_array = []
	var oob_y
	var oob_x
	
	
	if rotate == 0 or rotate == 2:
		oob_y = value.y
		for i in range(item_y):
			oob_x = value.x
			for j in range(item_x):
				if oob_x < min_x || oob_x > max_x:
					oob_array.append(true)
				elif oob_y < min_y || oob_y > max_y:
					oob_array.append(true)
				else: oob_array.append(false)
				oob_x = oob_x + 1
			oob_y = oob_y + 1
	else:
		oob_x = value.x
		for width in range(item_y):
			oob_y = value.y
			for height in range(item_x):
				if oob_x < min_x || oob_x > max_x:
					oob_array.append(true)
				elif oob_y < min_y || oob_y > max_y:
					oob_array.append(true)
				else: oob_array.append(false)
				oob_y = oob_y + 1
			oob_x = oob_x + 1
	
	if oob_array.has(true):
		return true
	else: return false

func stuff(thing, item):
	var temp_storage = []
	var temp_check = []
	
	var rotated_map = []
	
	if rotate == 1:
		for width in range(item[2][0].size()):#rows
			var row = []
			for height in range(item[2].size()-1, -1, -1):#columns
				row.append(item[2][height][width])
			rotated_map.append(row)
	elif rotate == 2:
		for height in range(item[2].size()-1, -1, -1):
			var row = []
			for width in range(item[2][0].size()-1, -1, -1):
				row.append(item[2][height][width])
			rotated_map.append(row)
	elif rotate == 3:
		for width in range(item[2][0].size()-1, -1, -1):
			var row = []
			for height in range(item[2].size()):
				row.append(item[2][height][width])
			rotated_map.append(row)
	
	var atlas_y
	var atlas_x
	var cell_y
	var cell_x
	
	if item[3] != 0 and rotate == 1: #90
		atlas_x = item[1].x
		cell_y = thing.y
		for height in range(item[2][0].size()):
			atlas_y = item[1].y + item[2].size() - 1
			cell_x = thing.x
			for width in range(item[2].size()):
				if rotated_map[height][width] == 1:
					temp_storage.append([Vector2i(cell_x, cell_y), Vector2i(atlas_x, atlas_y)])
					temp_check.append(Vector2i(cell_x, cell_y))
				atlas_y -= 1
				cell_x +=1
			atlas_x += 1
			cell_y += 1
			
	elif item[3] != 0 and rotate == 2: #180
		atlas_y = item[1].y + item[2].size() - 1 
		cell_y = thing.y
		for height in range(item[2].size()):
			atlas_x = item[1].x + item[2][0].size() - 1 
			cell_x = thing.x
			for width in range(item[2][0].size()):
				if rotated_map[height][width] == 1:
					temp_storage.append([Vector2i(cell_x, cell_y), Vector2i(atlas_x, atlas_y)])
					temp_check.append(Vector2i(cell_x, cell_y))
				atlas_x -= 1
				cell_x += 1
			atlas_y -= 1
			cell_y += 1
			
	elif item[3] != 0 and rotate == 3: #270
		atlas_x = item[1].x + item[2][0].size() - 1
		cell_y = thing.y
		for height in range(item[2][0].size()):
			atlas_y = item[1].y
			cell_x = thing.x
			for width in range(item[2].size()):
				if rotated_map[height][width] == 1:
					temp_storage.append([Vector2i(cell_x, cell_y), Vector2i(atlas_x, atlas_y)])
					temp_check.append(Vector2i(cell_x, cell_y))
				atlas_y += 1
				cell_x += 1
			atlas_x -= 1
			cell_y += 1
			
	else: # 0 - 360
		atlas_y = item[1].y
		cell_y = thing.y
		for height in range(item[2].size()):
			atlas_x = item[1].x
			cell_x = thing.x
			for width in range(item[2][0].size()):
				if item[2][height][width] == 1:
					temp_storage.append([Vector2i(cell_x, cell_y), Vector2i(atlas_x, atlas_y)])
					temp_check.append(Vector2i(cell_x, cell_y))
				cell_x += 1
				atlas_x += 1
			cell_y += 1
			atlas_y += 1
	
	
	item_storage.append(temp_storage)
	check_list.append(temp_check)


func _button_pressed():
	if Chisel_Button.disabled == true:
		Hammer_Button.disabled = true
		Chisel_Button.disabled = false
	elif Hammer_Button.disabled == true:
		Chisel_Button.disabled = true
		Hammer_Button.disabled = false

func _input(event: InputEvent):
	var loc_x = local_to_map(get_local_mouse_position()).x
	var loc_y = local_to_map(get_local_mouse_position()).y
	
	if event.is_action_pressed("Stop"):
		get_tree().quit()
	
	if event.is_action_pressed("Clear"):
		clear()
		
		Health = 49
		True_Found = 0
		items_generated.text = "/" + str(number_of_items)
		Items_Found.text = str(True_Found)
		
		item_storage = []
		check_list = []
		rotated_items = []
		cells_with_items = []
		
		update_health(0)
		map_generation()
		while map_arr.count(2) < 10 || map_arr.count(4) < 30:
			clear()
			map_generation()
		
		place_items()
	
	if !(event is InputEventMouseButton) and !(event is InputEventKey) || Health <= 0 || True_Found == number_of_items:
		return
		
	if loc_x >= 0 and loc_x <= 12 and loc_y >= 0 and loc_y <= 9:
		if event.is_action_pressed("Click") || event.is_action_pressed("Use") and Chisel_Button.disabled == true:
			chisel(local_to_map(get_local_mouse_position()))
			Chisel_Button.disabled = true
			Hammer_Button.disabled = false
		elif event.is_action_pressed("Alt-Click") || event.is_action_pressed("Use") and Hammer_Button.disabled == true:
			hammer(local_to_map(get_local_mouse_position()))
			Chisel_Button.disabled = false
			Hammer_Button.disabled = true
	check_found()
	Items_Found.text = str(True_Found)
	
func chisel(cell):
	var above = Vector2i(cell[0],cell[1]+1)
	var below = Vector2i(cell[0],cell[1]-1)
	var right = Vector2i(cell[0]+1,cell[1])
	var left = Vector2i(cell[0]-1,cell[1])
	var chisel_list = [
		cell, above, below, right, left
	]
	
	get_tile_cell(chisel_list, "chisel")
	update_health(1)

func hammer(cell):
	var above = Vector2i(cell[0],cell[1]+1)
	var below = Vector2i(cell[0],cell[1]-1)
	var right = Vector2i(cell[0]+1,cell[1])
	var left = Vector2i(cell[0]-1,cell[1])
	
	var top_right = Vector2i(cell[0]+1,cell[1]+1)
	var top_left = Vector2i(cell[0]-1,cell[1]+1)
	var bot_right = Vector2i(cell[0]+1,cell[1]-1)
	var bot_left = Vector2i(cell[0]-1,cell[1]-1)
	
	var hammer_list = [
		cell, above, below, right, left, top_right, top_left, bot_right, bot_left
	]
	
	get_tile_cell(hammer_list, "hammer")
	update_health(3)

func get_tile_cell(cell_type, tool):
	var layer
	var count = 0
	if tool == "chisel":
		for each in cell_type:
			var tile_match = false
			var tile
			var tileAlt = 0
			
			layer = CELLS.find_key(get_cell_atlas_coords(each))
			if layer == null:
				continue
			elif cell_type.find(each) == 0:
				layer = layer - 2
			elif cell_type.find(each) == -1:
				layer = -1
			else:
				layer = layer - 1
			
			count = 0
			for item in item_storage:
				
				for place in item:
					if layer <= 0 && place[0] == each:
						tile_match = true
						tile = place[1]
						
						if rotated_items[count] > 0:
							match rotated_items[count]:
								1: #rotate tile 90
									tileAlt = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_H
								2: #rotate tile 180
									tileAlt = TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_FLIP_V
								3: #rotate tile 270
									tileAlt = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_V
									
					elif layer <= 0:
						layer = -1
				count += 1
			if tile_match == true:
				set_cell(each, 1, tile, tileAlt)
			else:
				set_tile_cell(each, layer)
	elif tool == "hammer":
		for each in cell_type:
			var tile_match = false
			var tile
			var tileAlt = 0
			
			layer = CELLS.find_key(get_cell_atlas_coords(each))
			
			if layer == null:
				continue
			elif cell_type.find(each) <= 4:
				layer = layer - 2
			elif cell_type.find(each) == -1:
				layer = -1
			else:
				layer = layer - 1
			count = 0
			for item in item_storage:
				for place in item:
					if layer <= 0 && place[0] == each:
						tile_match = true
						tile = place[1]
						
						if rotated_items[count] > 0:
							match rotated_items[count]:
								1: #rotate tile 90
									tileAlt = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_H
								2: #rotate tile 180
									tileAlt = TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_FLIP_V
								3: #rotate tile 270
									tileAlt = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_V
				
					elif layer <= 0:
						layer = -1
				count += 1
			if tile_match == true:
				set_cell(each, 1, tile, tileAlt)
			else:
				set_tile_cell(each, layer)

func set_tile_cell(cell_coord, cell_type):
	set_cell(cell_coord, CELL_TILE_SET_ID, CELLS[cell_type])

func check_found():
	var found_list = []
	
	for i in range(13):
		for j in range(10):
			if CELLS.find_key(get_cell_atlas_coords(Vector2i(i,j))) == null:
				found_list.append(Vector2i(i,j))

	for item in check_list:
		var Found = 0
		var temp_arr = []
		for piece in item:
			temp_arr.append(piece)
		
		for place in found_list:
			if temp_arr.has(place):
				Found = Found + 1
				
		if Found == temp_arr.size():
			check_list.erase(item)
			True_Found = True_Found + 1

func update_health(dmg):
	Health = Health - dmg
	var id = Health/3.33
	var spot = Vector2i(0,-1)
	var source = 0
	
	if id < 15.0 and id >= 13.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[1])
	elif id < 13.0 and id >= 12.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[2])
	elif id < 12.0 and id >= 11.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[3])
	elif id < 11.0 and id >= 10.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[4])
	elif id < 10.0 and id >= 9.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[5])
	elif id < 9.0 and id >= 8.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[6])
	elif id < 8.0 and id >= 7.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[7])
	elif id < 7.0 and id >= 6.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[8])
	elif id < 6.0 and id >= 5.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[9])
	elif id < 5.0 and id >= 4.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[10])
	elif id < 4.0 and id >= 3.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[11])
	elif id < 3.0 and id >= 2.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[12])
	elif id < 2.0 and id >= 1.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[13])
	elif id < 1.0 and id >= 0.0:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[14])
	else:
		Health_Layer.set_cell(spot, 0, HEALTH_BAR[15])
