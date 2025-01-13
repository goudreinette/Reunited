extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func start(pos):
	position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AudioStreamPlayer2D.finished.connect(queue_free)
	pass
