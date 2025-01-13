extends PathFollow2D


# Called when the node enters the scene tree for the first time.
@export var speed = 0.1

func _process(delta: float) -> void:
	progress_ratio += delta * speed
	pass
