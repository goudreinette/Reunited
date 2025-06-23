extends Node2D

@export var next_level: PackedScene

var can_go_to_next_level = false

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("Cubania Bar")

func _on_dialogic_signal():
	pass
	
func _on_timeline_ended():
	can_go_to_next_level = true
	
	
func _input(event):
	if event.is_action_pressed("Level trigger q") and can_go_to_next_level:
		get_tree().change_scene_to_packed(next_level)
