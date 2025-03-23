extends PathFollow3D

@export var speed = 0.5

func _physics_process(delta: float) -> void:
	progress +=speed
	
