extends Area2D

@export var speed = 150


func start(pos,rot, spd = speed):
	position = pos
	rotation = rot
	speed = spd
	
func _process(delta):
	position += Vector2(0, speed * delta).rotated(rotation)




func _on_area_entered(area):
	if area.name == "Player" and not area.barelling:
		queue_free()
		area.shield -= 1

func _on_death_timer_timeout() -> void:
	queue_free()
