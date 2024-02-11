extends TileMap

export var max_enemy_count = 4
var ENEMY_SPAWN_POINT_TILE_ID = 1

var enemy_scene = preload("res://scenes/enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	# if get_enemy_count() < max_enemy_count:
	# 	spawn_enemy()
	pass

func spawn_enemy():
	# Find a random spawn point
	var spawn_points = get_used_cells_by_id(ENEMY_SPAWN_POINT_TILE_ID)
	var spawn_point = spawn_points[randi() % spawn_points.size()]
	var spawn_point_world = map_to_world(spawn_point)
	var enemy = enemy_scene.instance()
	enemy.position = spawn_point_world
	add_child(enemy)

func get_enemy_count():
	return get_tree().get_nodes_in_group("enemies").size()
