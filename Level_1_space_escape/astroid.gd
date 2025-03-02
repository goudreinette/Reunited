extends Area2D

signal died 

@export var maxhealth : int = 5 
@export var health : int  
var healthratio : float 
var explode_scene = preload("res://Effects/Big Explosion.tscn")
var isdead : bool = false

func _ready() -> void:
	health = maxhealth
func _process(delta: float) -> void:
	if health <=0 and not isdead:
		explode()

	
func reduce_health(amount):
	health -= amount
	#if health > 0:
	$HitAnimation.play("hit")
	
func explode():
	isdead = true
	#$AnimationPlayer.play("explode")
	#$AudioStreamPlayer2D.play()
	set_deferred("monitorable", false)
	var e = explode_scene.instantiate()
	get_tree().root.add_child(e)
	e.start(global_position)
	
	died.emit(5)
	await $HitAnimation.animation_finished # Needed to 
	process_mode = Node.PROCESS_MODE_DISABLED
	
	#queue_free()
