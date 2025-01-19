extends Node2D

#@export var levelpos : int = 0
@export var levelspeed : float = 30
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= levelspeed*delta
	#print(position.y)
