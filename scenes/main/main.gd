extends Control

onready var world = get_node("%World")
onready var player = get_node("%Player")
var speed = 500 # speed of movement
var rotation_speed = 5 # speed of rotation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2() # velocity vector

	var movement_strength = (Input.get_action_strength("ui_up")-Input.get_action_strength("ui_down"))
	var rotation_strength = (Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left"))

	# check for key presses
	if movement_strength:
		velocity = movement_strength * Vector2(0, -speed).rotated(player.rotation)
	if rotation_strength:
		player.rotation += rotation_strength * rotation_speed * delta

	# move and slide the node
	player.move_and_slide(velocity)
