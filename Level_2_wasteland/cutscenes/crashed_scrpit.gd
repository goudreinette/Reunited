extends Node2D

@export var next_level: PackedScene
@export var waiting_time: float = 6.0


func _ready() -> void:
	await get_tree().create_timer(waiting_time).timeout
	get_tree().change_scene_to_packed(next_level)
