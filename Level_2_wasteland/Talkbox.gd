extends Area2D

var player_inside : bool = false
@export var next_convo : int = 0
@export var next_card_convo : int = 0
var is_talking : bool = false
@export var convos : = ["convo_1","convo_2"]
@export var card_convos : = ["convo_1","convo_2"]

@export var doors: Array[StaticBody2D]

var has_card = false

#@export var pressx : Sprite2D 

func _ready():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func _on_dialogic_signal(argument:String):
	pass
	
func _process(delta: float) -> void:
	if player_inside and not is_talking :
		$PressX.visible = true
		if  Input.is_action_just_pressed("dialogic_default_action"):
			is_talking = true
			if has_card == false and next_convo < convos.size():
				Dialogic.start(convos[next_convo])
			else: 
				Dialogic.start(card_convos[next_card_convo])
				if next_card_convo == 0: 
					for door in doors:
						door.open_door()
				
			#has_entered = true
	else: $PressX.visible = false	
	
	
func _on_timeline_ended():
	## To check if it is OUR timeline
	if is_talking :
		await get_tree().create_timer(0.3).timeout
		is_talking = false
		if next_convo < convos.size(): 
			next_convo += 1
#func _on_end_of_convo_timer_timeout() -> void:
	#is_talking = false
	#
func _on_body_entered(body: Node2D) -> void:
	if body is Player :
		player_inside = true
		if body.has_card: 
			has_card = true
			print()
func _on_body_exited(body: Node2D) -> void:
	if body is Player :
		player_inside = false 
	
	



func _on_player_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
