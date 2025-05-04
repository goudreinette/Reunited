extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("plyer trying to talk to ander mannetje!")
		Dialogic.start("gesprek_stephan_andermannetje")
	
