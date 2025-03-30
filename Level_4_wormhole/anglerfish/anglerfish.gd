extends AnimatedSprite2D


@export var speed = 1

func _process(delta):
	position.x += speed * delta
