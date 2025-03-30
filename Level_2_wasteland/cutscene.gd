extends Area2D

@export var characters : Array[CharacterBody2D] = []
@export var move_time: float = 3
var is_talking = false

func _ready():
	$MoveTimer.wait_time = move_time
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		start_cutscene()
		
		
func start_cutscene():
	$MoveTimer.start()
	for i in characters:
		i.move_to(i.next_position.position,move_time)
	
		


func _on_move_timer_timeout() -> void:
	if not is_talking: 
		Dialogic.start("Ship_fixed")
		is_talking = true
