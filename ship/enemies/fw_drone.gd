extends Area2D

signal died
var explode_scene = preload("res://explosion.tscn")

# Called when the node enters the scene tree for the first time.
func explode():
	#get_parent().speed
	#$AnimationPlayer.play("explode")
	#$AudioStreamPlayer2D.play()
	#set_deferred("monitorable", false)
	#await $AnimationPlayer.animation_finished
	died.emit(5)
	##spawn explosion
	var e = explode_scene.instantiate()
	get_tree().root.add_child(e)
	e.start(global_position)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
