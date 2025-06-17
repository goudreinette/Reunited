class_name Cutscene extends AnimationPlayer


@export var cutscene_animations: Array[String]
@export var next_animation = 0
@export var next_level: PackedScene

var faded_in: bool = false


func _input(event):
	if event.is_action_pressed("Level trigger q"):
		play(cutscene_animations[next_animation])
		next_animation+=1


func _on_animation_finished(anim_name):
	if anim_name == cutscene_animations[cutscene_animations.size()-1]:
		get_tree().change_scene_to_packed(next_level)
