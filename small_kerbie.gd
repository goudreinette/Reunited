extends Area2D
@export var shield: Sprite2D 
@export var visibletime: float = 0.2
func _ready() -> void:

	shield.modulate = Color(0,0,0,0)

func showshield():
	shield.modulate = Color(1,1,1,1)
	var tween = create_tween()
	tween.tween_property(shield,"modulate", Color(0,0,0,0), visibletime)
	
	
	
