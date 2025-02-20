extends Area2D

var player_inside : bool = false
@export var next_convo : int = 0
var is_talking : bool = false
@export var convos : = ["convo_1","convo_2"]

#@export var pressx : Sprite2D 

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
func _on_dialogic_signal(argument:String):
	pass
	
func _process(delta: float) -> void:
	if player_inside and not is_talking :
		$PressX.visible = true
		if  Input.is_action_just_pressed("dialogic_default_action"):
			is_talking = true
			Dialogic.start(convos[next_convo])
			#has_entered = true
	else: $PressX.visible = false	
	
	
func _on_timeline_ended():
	$end_of_convo_timer.start()
	if next_convo < convos.size()-1: next_convo += 1
func _on_end_of_convo_timer_timeout() -> void:
	is_talking = false
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player :
		player_inside = true
func _on_body_exited(body: Node2D) -> void:
	if body is Player :
		player_inside = false 
