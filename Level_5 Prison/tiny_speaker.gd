extends AnimatedSprite2D


func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func _on_dialogic_signal(argument:String):
	if argument == "Speaker":
		play("Speaking")
	if argument == "Stop Speaker":
		play("Idle")
