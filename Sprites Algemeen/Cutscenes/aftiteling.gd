extends Node2D

@export var next_scene: PackedScene

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Level trigger q"):
		get_tree().change_scene_to_packed(next_scene)
