extends AudioStreamPlayer


func _on_level_0_walkin_current_animation_changed(name):
	if name == "lightson":
		play()
