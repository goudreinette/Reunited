extends Node2D

@export var next_scene: PackedScene

var aftiteling_started = false
var aftiteling_done = false
var fadeout_done = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Level trigger q"):
		if not aftiteling_started:
			aftiteling_started = true
			$AnimationPlayer.play("aftiteling")
		if aftiteling_done and not fadeout_done:
			fadeout_done = true
			$AnimationPlayer.play("fadeout")
		if fadeout_done:
			get_tree().change_scene_to_packed(next_scene)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "aftiteling":
		aftiteling_done = true
