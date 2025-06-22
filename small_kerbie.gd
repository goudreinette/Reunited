extends Area2D
@export var shield: Sprite2D 
@export var visibletime: float = 0.2

@export var move_away_time: float = 1
@export var move_in_time: float = 3.0
var hover_shake = HoverShake2D.new()
@export var does_hover:bool = false

###shooting
@export var bullet_scene: PackedScene
@export var reload_speed_normal:float = 0.6
@export var reload_speed_fast:float = 0.1

@export var shoot: bool = true
@export var can_shoot: bool = false
@export var can_shoot_fast: bool = false

func _ready() -> void:
	
	shield.modulate = Color(0,0,0,0)
	hover_shake.init(self,"random",1,0,2)
	$"reload timer".wait_time = reload_speed_normal
	Dialogic.signal_event.connect(_on_dialogic_signal)
func _on_dialogic_signal(argument:String):
	if argument == "Slow shoot":
		can_shoot =true
	if argument == "Fast shoot":
		can_shoot_fast =true

var last_x: float
func _process(delta: float) -> void:
	if does_hover: hover_shake.update(delta)
	
	if last_x > global_position.x:
		$Sprite2D.flip_h = true
	elif last_x < global_position.x: $Sprite2D.flip_h = false
	last_x = global_position.x
	
	if can_shoot:
		if can_shoot_fast == false:
			if shoot:
				shoot_default()
		else:
			if shoot:
				shoot_scatter()
	

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
	
func shoot_default():
	
	$"reload timer".wait_time = reload_speed_normal
	$"reload timer".start()
	var b = bullet_scene.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(global_position + Vector2(0, -8), deg_to_rad(rotation))
	shoot = false
	
func shoot_scatter():
	$"reload timer".wait_time = reload_speed_fast
	$"reload timer".start()
	
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(global_position + Vector2(0, -8), deg_to_rad(rotation+15))
	
	b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(global_position + Vector2(0, -8), deg_to_rad(rotation))
	
	b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(global_position + Vector2(0, -8), deg_to_rad(rotation-15))
	pass

func _on_reload_timer_timeout() -> void:
	shoot = true
