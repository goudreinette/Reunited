extends Area2D

@export var next_level: PackedScene
@export var waiting_time: float = 6.0



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		await get_tree().create_timer(waiting_time).timeout
		get_tree().change_scene_to_packed(next_level)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		await get_tree().create_timer(waiting_time).timeout
		get_tree().change_scene_to_packed(next_level)
