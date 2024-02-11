extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bullet_body_entered(body):
	# if body belong to "walls" group, destroy the bullet
	if body.is_in_group("walls"):
		queue_free()
	elif body.is_in_group("enemies"):
		queue_free()
		# TODO show enemy destroyed animation
		body.queue_free()

func _on_Timer_timeout():
	# Destroy after a second
	queue_free()
