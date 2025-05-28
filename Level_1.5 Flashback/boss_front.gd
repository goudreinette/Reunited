extends Sprite2D

@export var target: Node2D
@export var move_time: float = 2.0

@export var move_away_time: float = 1
func move():
	var tween = create_tween()
	tween.tween_property(self,"position",target.position,move_time)
	
	
func move_away():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"position",Vector2(0,500), move_away_time)
	tween.parallel().tween_property(self,"scale",Vector2(0.1,0.1), 5)
	pass
