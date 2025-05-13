extends Area2D

@export var deathtimer: float = 4.0

func _ready() -> void:
	await get_tree().create_timer(deathtimer).timeout
	queue_free()

func start(pos = position):
	position = pos
	await get_tree().create_timer(deathtimer).timeout
	queue_free()
	
