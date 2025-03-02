extends Node2D


func shoot():
	print("shoot")
	$WarnTimer.start()
	$AnimationPlayer.play("warning")

func _on_warn_timer_timeout() -> void:
	print("warn")
	$AnimationPlayer.play("charge")
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "charge" :
		$AnimationPlayer.play("shoot")
	if anim_name == "shoot" :
		$AnimationPlayer.play("hold")
		$HoldTimer.start()
	if anim_name == "release" :
		queue_free()
		
func _on_hold_timer_timeout() -> void:
	$AnimationPlayer.play("release")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		area.in_lazer = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "Player":
		area.in_lazer = false
