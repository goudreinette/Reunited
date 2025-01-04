extends Control




func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Walking Scenes/playground.tscn")


func _on_credits_pressed() -> void:
	print("credits")
