extends Area2D

@export var characters : Array[CharacterBody2D] = []
@export var move_time: float = 3
@export var next_level: PackedScene

var is_talking = false


func _ready():
	$MoveTimer.wait_time = move_time
	#Dialogic.timeline_ended.connect(_on_timeline_ended)
	
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
### for going to the next scene
#func _on_timeline_ended():
	#get_tree().change_scene_to_packed(next_level)
