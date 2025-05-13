extends Area2D

@export var time : float = 2
@export var target: Vector2
@export var splash_scene : PackedScene 

#func _init() -> void:
	#start()

func start(pos = position,tar = Vector2(20,20), tim = time):
	position = pos
	target = tar
	time = tim
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"position", target, time)
	tween.tween_callback(splash)
	tween.tween_callback(queue_free)
#func _process(delta):
	#position += Vector2(0, speed * delta).rotated(rotation)

func _on_area_entered(area):
	if area.name == "Player" and not area.barelling:
		queue_free()
		area.shield -= 1

func _on_death_timer_timeout() -> void:
	queue_free()

func splash():
	print(splash)
	var s = splash_scene.instantiate()
	get_tree().root.add_child(s)
	s.start(global_position)
