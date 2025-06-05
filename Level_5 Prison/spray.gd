extends Area2D



func retract():
	$AnimationPlayer.play("retract")
	set_collision_mask_value(1,false)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.detected = true
