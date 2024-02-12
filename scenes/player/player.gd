extends KinematicBody2D

var bullet_scene = preload("res://scenes/bullet/bullet.tscn")

var speed = 500 # speed of movement
var rotation_speed = 5 # speed of rotation

func _physics_process(delta):
	var velocity = Vector2() # velocity vector

	var updown_strength = (Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down"))
	var sidewise_strength = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))

	if Input.is_action_pressed("strafe"):
		# Strafing logic: Move sideways based on sidewise_strength without rotating
		if sidewise_strength != 0:
			velocity += Vector2(sidewise_strength, 0).normalized().rotated(rotation) * speed
		if updown_strength != 0:
			velocity += Vector2(0, -updown_strength).normalized().rotated(rotation) * speed

		# trim velocity to make sure the player doesn't move faster diagonally
		velocity = velocity.clamped(speed)
	else:
		# Normal movement logic
		if updown_strength:
			velocity += Vector2(0, -updown_strength * speed).rotated(rotation)
		if sidewise_strength:
			rotation += sidewise_strength * rotation_speed * delta

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
