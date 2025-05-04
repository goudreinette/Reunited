extends Node2D

@export var bullet_scene : PackedScene
@export var bullet_amount : float = 12.0
@export var bullet_speed = 100


func _ready() -> void:
	
	circle_shot(bullet_scene,bullet_amount,bullet_speed)

func circle_shot(scn,amt,spd):
	for n in amt:
		var b = scn.instantiate()
		get_tree().root.add_child.call_deferred(b)
		## elke 60 graden schieten want PI = 180 radians
		var d = PI/(amt/2.0) 
		b.start(global_position, n * d,spd)
