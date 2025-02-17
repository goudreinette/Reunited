extends AnimatedSprite2D
var player_in_mouth : bool = false

#func _on_trap_area_area_entered(area):
	#play("default")


func _on_trap_area_body_entered(body):
	play("default")
	$Shadow.play("default")
	if body.name == "Player":
		player_in_mouth = true
		body.dead()
	
