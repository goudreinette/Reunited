extends Sprite2D

var has_entered_1 : bool = false
var has_entered_2 : bool = false

func _on_koen_dialoog_1_body_entered(body: Node2D) -> void:
		if body is Player :
			if not has_entered_1 :
				Dialogic.start("Koen_Dialogue_1")
				has_entered_1 = true
			else :
				Dialogic.start("Koen_Dialogue_2")
		
func _on_koen_dialoog_3_body_entered(body: Node2D) -> void:
		if body is Player :
			if not has_entered_2 :
				Dialogic.start("Koen_Dialogue_3")
				has_entered_2 = true
				##he starts playin
				frame = 1
			else :
				Dialogic.start("Koen_Dialogue_4")

			
