extends AnimatedSprite2D


@export var start = false
@export var die = false

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start == true :
		play("default")
	if die:
		queue_free()



func _on_animation_finished() -> void:
	start = false
