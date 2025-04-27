extends Area2D

@export var bullet_scene : PackedScene
@export var bullet_amount : float = 50
@export var bullet_speed = 100
@export var shoot_pos: Node2D

func _on_timer_timeout() -> void:
	#circle_shot(bullet_scene,bullet_amount,bullet_speed)
	pass

func circle_shot(scn,amt,spd):
	for n in amt:
		var b = scn.instantiate()
		get_tree().root.add_child.call_deferred(b)
		## PI = 180 graden in radians. dus als je 2*pi deelt door de hoeveelheid kogels verdeelt hij de kogels gelijkmakig
		var d = PI*2/amt
		b.start(shoot_pos.global_position, n * d,spd)




func _on_hallucigenia_animation_looped() -> void:
	circle_shot(bullet_scene,bullet_amount,bullet_speed)
