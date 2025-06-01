extends Area2D

var player_in_range = false


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_range = true
