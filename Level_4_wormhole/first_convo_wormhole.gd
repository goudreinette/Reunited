extends Area2D


@export var convo : String = "Wormhole 1"
var convo_gestart: bool = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") and not convo_gestart:
		Dialogic.start(convo)
		convo_gestart = true
