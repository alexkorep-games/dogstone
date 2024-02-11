extends KinematicBody2D

var speed = 100
var velocity = Vector2()
var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

onready var initial_position = global_position

var spotted = false

func _ready():
	_choose_direction()

func _choose_direction():
	var dir = directions[randi() % directions.size()] if spotted else Vector2.ZERO
	_set_direction(dir)

func _set_direction(new_direction):
	velocity = new_direction.normalized() * speed
	# Rotate the sprite to match the direction
	var sprite = get_node("%Sprite")
	sprite.rotation = velocity.angle() + PI / 2

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	var dir_to_player = _get_visible_direction_to_player()
	if dir_to_player != null:
		# If the player is visible, move towards the player
		spotted = true
		_set_direction(dir_to_player)
	elif collision:
		# Choose a new direction if we hit a wall
		_choose_direction()  

func _get_visible_direction_to_player():
	# Get the nodes in the group "player"
	var player = get_tree().get_nodes_in_group("player")[0]
	var raycast = get_node("%RayCast2D")

	var direction_to_player = (player.global_position - global_position).normalized()
	var distance_to_player = global_position.distance_to(player.global_position)
	
	raycast.cast_to = direction_to_player * distance_to_player
	raycast.force_raycast_update()  # Update the raycast immediately
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider == player:
			return direction_to_player
		else:
			return null

func _on_ChangeDirectionTimer_timeout():
	_choose_direction()
