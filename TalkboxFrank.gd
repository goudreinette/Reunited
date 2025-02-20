extends Area2D

var player_inside : bool = false
var next_convo : int = 0
var is_talking : bool = false
var player_has_card : bool
@export var convos = ["frank_1","frank 2","Frank_vrij_1","frank_vrij_2"]
##[0]&[1] = frank gevangen
##[2]&[3] = frank gevangen
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	
func _on_dialogic_signal(argument:String):
	if argument == "Open de deur":
		$EngineRoom/AnimationPlayer.play("Door opens")
	if argument == "Frank Gitaar":
		get_parent().frame = 1
	
func _process(delta: float) -> void:
	#print(next_convo)
	if player_inside and not is_talking :
		$PressX.visible = true
		if  Input.is_action_just_pressed("dialogic_default_action"):
				Dialogic.start(convos[0])
				is_talking = true
	else: $PressX.visible = false	


func _on_timeline_ended():
	## Een Timer anders start hij vanzelf de volgende convo
	$end_of_convo_timer.start()	
	## Frank is niet vrij
	if next_convo < 1 : next_convo = 1
	## frank is vrij
	elif player_has_card : next_convo = 3
func _on_end_of_convo_timer_timeout() -> void:
	is_talking = false

##checken of de speler in de box zit en of ie de card heeft
func _on_body_entered(body: Node2D) -> void:
	if body is Player :
		player_inside = true
		if body.has_card : 
			player_has_card = true
			if next_convo < 2 : next_convo = 2
func _on_body_exited(body: Node2D) -> void:
	if body is Player :
		player_inside = false 
