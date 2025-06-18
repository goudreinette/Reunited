extends Area2D
@export var shield: Sprite2D 
@export var visibletime: float = 0.2

@export var move_away_time: float = 1
@export var move_in_time: float = 3.0
var hover_shake = HoverShake2D.new()
@export var does_hover:bool = false

func _ready() -> void:
	shield.modulate = Color(0,0,0,0)
	hover_shake.init(self,"random",1,0,2)


#func _process(delta: float) -> void:
	#if Input.is_action_pressed("shoot"):
		#move_away()
	#pass
var last_x: float
func _process(delta: float) -> void:
	if does_hover: hover_shake.update(delta)
	
	if last_x > global_position.x:
		$Sprite2D.flip_h = true
	elif last_x < global_position.x: $Sprite2D.flip_h = false
	last_x = global_position.x
	pass

func showshield():
	shield.modulate = Color(1,1,1,1)
	var tween = create_tween()
	tween.tween_property(shield,"modulate", Color(0,0,0,0), visibletime)

func move_to(target:Node2D):
	var tween = create_tween()
	tween.tween_property(self ,"global_position" ,target.global_position ,move_in_time)


func move_away():
	var tween = create_tween()
	##zorgen dat hij de goede kant op kijkt
	
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"position",Vector2(240,0), move_away_time)
	tween.parallel().tween_property(self,"scale",Vector2(0.1,0.1), 5)
	pass

	
