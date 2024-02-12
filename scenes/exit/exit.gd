extends Node2D

export(String, FILE, "*.tscn") var next_level_scene_path

signal triggered

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("%AnimationPlayer").play("rotate")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if next_level_scene_path != "":
			body.hide()
			emit_signal("triggered")
			get_node("%AnimationPlayer").play("teleport")
		else:
			print("Next level scene path not set.")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "teleport":
		var next_level_scene = load(next_level_scene_path)
		if next_level_scene:
			get_tree().change_scene_to(next_level_scene)
		else:
			print("Unable to load the scene: " + next_level_scene_path)
