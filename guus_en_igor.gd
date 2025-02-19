extends Area2D

var has_entered : bool = false


func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "Guus en Igor play":	
		$"Igor pos 1".visible = false
		$"Guus pos 1".visible = false
		$"Igor pos 2".visible = true
		$"Guus pos 2".visible = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player :
			if not has_entered :
				Dialogic.start("Guus_en_Igor_1")
				has_entered = true
			else :
				Dialogic.start("Guus_en_Igor_2")
		
