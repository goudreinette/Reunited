extends Area2D


# Called when the node enters the scene tree for the first time.
func explode():
	get_parent().speed
	$AnimationPlayer.play("explode")
	$AudioStreamPlayer2D.play()
	set_deferred("monitorable", false)
	await $AnimationPlayer.animation_finished
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
