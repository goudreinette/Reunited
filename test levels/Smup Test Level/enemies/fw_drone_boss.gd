extends Area2D

signal died
@export var health : int = 2
var explode_scene = preload("res://Effects/Smal explosion.tscn")
@export var main: Node

##hovering
@export var hover_amplitude_x = 1.0 # hoe ver hij op en neer beweegt
@export var hover_amplitude_y = 1.0
@export var hover_speed_x = 1.0 
@export var hover_speed_y = 1.0
@export var pickup_scene: PackedScene
	# hoe snel hij beweegt
var base_position = Vector2.ZERO
var time_passed = 0.0

func start(pos,rot,target_pos,time):
	position = pos
	rotation = rot
	scale = Vector2(0.4,0.4)
	##move to target and grow
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self,"position", target_pos, time)
	tween.tween_property(self,"scale", Vector2.ONE, time)
	
	#hovering
	base_position = target_pos
	hover_amplitude_x += randf_range(-1.0,1.0)
	hover_amplitude_y += randf_range(-1.0,1.0)
	hover_speed_x += randf_range(-1.0,1.0)
	hover_speed_y += randf_range(-1.0,1.0)
	
func reduce_health(amount):
	health -= amount
	$HitAnimation.play("hit")
	if health<=0 :
		explode()
		
	
func _process(delta: float) -> void:
	
	time_passed += delta
	position.y = base_position.y + sin(time_passed * hover_speed_y) * hover_amplitude_y
	position.x = base_position.x + cos(time_passed * hover_speed_x) * hover_amplitude_x
	
	

# Called when the node enters the scene tree for the first time.
var pickup_has_spawned = false
func explode():
	#get_parent().speed
	#$AnimationPlayer.play("explode")
	#$AudioStreamPlayer2D.play()
	#set_deferred("monitorable", false)
	#await $AnimationPlayer.animation_finished
	
	if pickup_has_spawned == false:
		pickup_has_spawned = true
		var i = randi_range(1,2)
		if i == 1: 
			var p = pickup_scene.instantiate()
			get_tree().root.add_child(p)
			p.start(global_position,false,true)
		
	$HitAnimation.play("RESET")
	died.emit(5)
	##spawn explosion
	var e = explode_scene.instantiate()
	get_tree().root.add_child(e)
	e.start(global_position)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
