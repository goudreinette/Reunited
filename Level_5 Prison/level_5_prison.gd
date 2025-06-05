extends Node2D

@export var prison_door_1:StaticBody2D
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	#Dialogic.timeline_ended.connect(_on_timeline_ended)
	### Gesprek begint ###
	#SpeakerSprite.play("Speaking")
	Dialogic.start("Prison 1")


var door_opened = false
func _on_dialogic_signal(argument:String):
	if argument == "Open Door" and not door_opened:
		prison_door_1.open_door()
		door_opened = true
