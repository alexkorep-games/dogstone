extends KinematicBody2D

var bullet_scene = preload("res://scenes/bullet/bullet.tscn")

var speed = 500 # speed of movement
var rotation_speed = 5 # speed of rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = Vector2() # velocity vector

	var movement_strength = (Input.get_action_strength("ui_up")-Input.get_action_strength("ui_down"))
	var rotation_strength = (Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left"))

	# check for key presses
	if movement_strength:
		velocity = movement_strength * Vector2(0, -speed).rotated(rotation)
	if rotation_strength:
		rotation += rotation_strength * rotation_speed * delta

	# move and slide the node
	move_and_slide(velocity)


func _on_GunTimer_timeout():
	# Shoot a bullet to the direction where the player is facing
	var bullet = bullet_scene.instance()
	var gun = get_node("%Gun")
	bullet.position = position + gun.position.rotated(rotation)
	bullet.rotation = rotation
	bullet.set_linear_velocity(Vector2(0, -1000).rotated(rotation))
	get_parent().add_child(bullet)
