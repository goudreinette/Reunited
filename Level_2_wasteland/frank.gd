extends Sprite2D

var has_entered_1 : bool = false
var has_entered_2 : bool = false

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "Open de deur":
		$EngineRoom/AnimationPlayer.play("Door opens")
	if argument == "Frank Gitaar":
		frame =1
		
func _on_talkbox_body_entered(body: Node2D) -> void:
		if body is Player and not body.has_card:
			if not has_entered_1 :
				Dialogic.start("frank_1")
				has_entered_1 = true	
			else :
				Dialogic.start("frank 2")
		else : 
			if not has_entered_2 :
				Dialogic.start("Frank_vrij_1")
				has_entered_2 = true	
			else :
				Dialogic.start("frank_vrij_2")
			
		
