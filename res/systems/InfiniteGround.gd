extends TileMap

@export var camera_path: NodePath

# Assuming the ground tile is the first tile (ID 0) from the first source (ID 0) in the TileSet
const GROUND_TILE_SOURCE_ID = 0
const GROUND_TILE_ATLAS_COORDS = Vector2i(0, 0) # Coords of the tile within the atlas source
const GROUND_TILE_ALTERNATIVE_ID = 0 # Alternative ID for the tile, usually 0
const GROUND_TILE_LAYER = 0 # TileMap layer to draw on

var tile_world_width: float
var camera: Camera2D

# Keep track of columns that have tiles
var active_tile_columns: Dictionary = {}

# How many extra tiles to load off-screen on each side as a buffer
@export var horizontal_buffer_tiles: int = 2


func _ready():
	if camera_path.is_empty():
		printerr("InfiniteGround: Camera path is not set!")
		set_physics_process(false)
		return

	camera = get_node_or_null(camera_path)
	if !is_instance_valid(camera):
		printerr("InfiniteGround: Camera node not found at path: ", camera_path)
		set_physics_process(false)
		return

	# Get tile width from the TileSet resource attached to this TileMap
	if !tile_set:
		printerr("InfiniteGround: TileSet is not assigned to this TileMap!")
		set_physics_process(false)
		return
	
	# Assuming square tiles for simplicity, or that tile_size.x is the relevant dimension
	tile_world_width = tile_set.tile_size.x
	if tile_world_width <= 0:
		printerr("InfiniteGround: Tile width is zero or invalid in TileSet!")
		set_physics_process(false)
		return

	# Initial fill
	_update_tiles()


func _physics_process(_delta):
	if !is_instance_valid(camera):
		return # Camera might have been freed
	_update_tiles()


func _update_tiles():
	# Calculate the horizontal range of the camera's view in world coordinates
	var viewport_rect = camera.get_viewport_rect()
	# Get camera's global position and zoom to calculate view edges
	var camera_global_center_x = camera.global_position.x
	var viewport_world_half_width = (viewport_rect.size.x / 2.0) * camera.zoom.x

	var global_left_edge_x = camera_global_center_x - viewport_world_half_width
	var global_right_edge_x = camera_global_center_x + viewport_world_half_width

	# Convert these global X coordinates to the TileMap's local coordinate system
	var camera_left_edge_local_x = self.to_local(Vector2(global_left_edge_x, 0)).x
	var camera_right_edge_local_x = self.to_local(Vector2(global_right_edge_x, 0)).x

	# Determine the range of tile column indices that need to be active
	var first_needed_col = floori(camera_left_edge_local_x / tile_world_width) - horizontal_buffer_tiles
	var last_needed_col = ceili(camera_right_edge_local_x / tile_world_width) + horizontal_buffer_tiles
	
	# Add new tiles
	for col_idx in range(first_needed_col, last_needed_col + 1):
		if !active_tile_columns.has(col_idx):
			var tile_coord = Vector2i(col_idx, 0) # Assuming ground is at Y=0 in tile coordinates
			set_cell(GROUND_TILE_LAYER, tile_coord, GROUND_TILE_SOURCE_ID, GROUND_TILE_ATLAS_COORDS, GROUND_TILE_ALTERNATIVE_ID)
			active_tile_columns[col_idx] = true
			# print("Added tile at column: ", col_idx)

	# Remove old tiles
	var columns_to_remove = []
	for col_idx in active_tile_columns.keys():
		if col_idx < first_needed_col - 1 || col_idx > last_needed_col + 1: # Extra -1/+1 for safety margin before removing
			columns_to_remove.append(col_idx)

	for col_idx in columns_to_remove:
		erase_cell(GROUND_TILE_LAYER, Vector2i(col_idx, 0))
		active_tile_columns.erase(col_idx)
		# print("Removed tile from column: ", col_idx)
