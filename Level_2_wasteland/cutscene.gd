extends Area2D

@export var characters : Array[CharacterBody2D] = []
@export var move_time: float = 3

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		start_cutscene()
		
		
func start_cutscene():
	for i in characters:
		i.move_to(i.next_position.position,move_time)
	
		
