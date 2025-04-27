extends Area2D



signal died
signal health_changed


enum stage{ONE,STAGE_TWO, STAGE_THREE}
@export var current_stage = stage.ONE
@export var max_health : int = 20
@export var health : int = 20
var explode_scene = preload("res://Effects/Smal explosion.tscn")
@export var main: Node


		
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
	get_tree().add_child(e)
	e.start(global_position)
	$HitAnimation.play("RESET")
	#queue_free()
func reduce_health(amount):
	health -= amount
	health_changed.emit(max_health, health)
	$HitAnimation.play("hit")
	if health<=0 :
		explode()
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
