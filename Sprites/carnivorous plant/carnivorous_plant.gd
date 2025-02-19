extends Sprite2D
var player_in_mouth : bool = false

#func _on_trap_area_area_entered(area):
	#play("default")



func _on_trap_area_body_entered(body):
	$AnimationPlayer.play("Attack")
	
	


func _on_kill_area_body_entered(body) -> void:
	if body.name == "Player" and not body.is_dashing:
			player_in_mouth = true
			body.dead()
