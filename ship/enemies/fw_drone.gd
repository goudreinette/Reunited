extends Area2D


signal died
@export var health : int = 2
var explode_scene = preload("res://Smal explosion.tscn")
@export var main: Node

func reduce_health(amount):
	health -= amount
	$HitAnimation.play("hit")
	if health<=0 :
		explode()
		
	
func _process(delta: float) -> void:
	pass
	
	

# Called when the node enters the scene tree for the first time.
func explode():
	#get_parent().speed
	#$AnimationPlayer.play("explode")
	#$AudioStreamPlayer2D.play()
	#set_deferred("monitorable", false)
	#await $AnimationPlayer.animation_finished
	$HitAnimation.play("RESET")
	died.emit(5)
	##spawn explosion
	var e = explode_scene.instantiate()
	get_parent().get_parent().get_parent().add_child(e)
	e.start(global_position)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
