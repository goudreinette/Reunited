extends Area2D




func _on_body_entered(body: Player) -> void:
	if body.name == "Player" :
		body.respawnnode = self
