class_name Cutscene extends AnimationPlayer


@export var cutscene_animations: Array[String]
@export var next_animation = 0
@export var next_level: PackedScene
@export var previous_level: PackedScene


func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _input(event):
	if event.is_action_pressed("Level trigger q"):
		if next_animation == cutscene_animations.size():
			get_tree().change_scene_to_packed(next_level)
		else:
			play(cutscene_animations[next_animation])

		next_animation+=1
