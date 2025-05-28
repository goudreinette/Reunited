extends Area2D
@export var shield: Sprite2D 
@export var visibletime: float = 0.2

@export var move_away_time: float = 1
func _ready() -> void:
	shield.modulate = Color(0,0,0,0)

#func _process(delta: float) -> void:
	#if Input.is_action_pressed("shoot"):
		#move_away()
	#pass

func showshield():
	shield.modulate = Color(1,1,1,1)
	var tween = create_tween()
	tween.tween_property(shield,"modulate", Color(0,0,0,0), visibletime)
	
	
func move_away():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"position",Vector2(240,0), move_away_time)
	tween.parallel().tween_property(self,"scale",Vector2(0.1,0.1), 5)
	pass

	
