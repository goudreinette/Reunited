extends Control




func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://ship/Shmup Test Level.tscn")


func _on_credits_pressed() -> void:
	print("credits")
