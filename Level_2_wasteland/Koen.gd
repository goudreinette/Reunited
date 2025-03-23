extends Node2D



func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func _on_dialogic_signal(argument:String):
	if argument == "koen_starts_playing":
		$Koen.visible = true
		#$Koen.frame = 1
		$KoenStuckInPlant.queue_free()
		
	
