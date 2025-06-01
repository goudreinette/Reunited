extends Node2D

@export var next_level: PackedScene

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("Cubania Bar")

func _on_dialogic_signal():
	pass
	
func _on_timeline_ended():
	get_tree().change_scene_to_packed(next_level)
