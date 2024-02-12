extends Node

# Variable to keep track of the number of active touches
var active_touches = 0

func _ready():
	# Make sure the input processing is enabled
	set_process_input(true)

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			# A new touch has begun
			active_touches += 1
		else:
			# A touch has ended
			active_touches -= 1
		
		# Simulate "strafe" action pressed when exactly two touches are active
		if active_touches == 2:
			Input.action_press("strafe")
		else:
			Input.action_release("strafe")
		
		print("Active touches: ", active_touches)
