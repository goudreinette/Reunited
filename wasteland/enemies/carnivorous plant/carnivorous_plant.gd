extends AnimatedSprite2D

#
#func _on_trap_area_area_entered(area):
	#play("default")


func _on_trap_area_body_entered(body):
	play("default")
	$Shadow.play("default")
