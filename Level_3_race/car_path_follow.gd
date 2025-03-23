extends PathFollow3D

@export var max_speed = 0.04
@export var acceleration = 0.0005
var speed = 0.0

var is_started: bool = false

func _physics_process(delta: float) -> void:
	if is_started:
		if speed < max_speed:
			speed += acceleration
		
	print(speed)
	progress += speed


func _on_timer_timeout():
	is_started = true
