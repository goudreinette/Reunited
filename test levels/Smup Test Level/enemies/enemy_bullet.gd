extends Area2D

@export var speed = 150


func start(pos,rot, spd = speed, sound =true):
	position = pos
	rotation = rot
	speed = spd
	if sound ==false :
		$ShingleShotExtraShort4.queue_free()
	
func _process(delta):
	position += Vector2(0, speed * delta).rotated(rotation)
	
func _on_area_entered(area):
	if area.name == "Player" and not area.barelling:
		queue_free()
		area.shield -= 1
	if area.is_in_group("Kerbie"):
		queue_free()
		area.showshield()
	if area.is_in_group("astroids"):
		queue_free()

func _on_death_timer_timeout() -> void:
	queue_free()
