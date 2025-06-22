extends Area2D



signal died
signal health_changed


enum stage{ONE,STAGE_TWO, STAGE_THREE}
@export var current_stage = stage.ONE
@export var max_health : float = 200
@export var health : float = 100
var explode_scene = preload("res://Effects/Smal explosion.tscn")
@export var main: Node
@export var shipparts: Array[Area2D] = []

@export var target_pos: Node2D
@export var move_in_time: float = 5
@export var next_scene: PackedScene
var can_fire = false
var can_die = false


func _ready() -> void:
	health = max_health
	await get_tree().create_timer(0.1).timeout
	health_changed.emit(max_health, health)

func _physics_process(delta: float) -> void:
	var destroyed_shipparts_count = 0
	for part in shipparts:
		if part.isdead:
			destroyed_shipparts_count+=1
	if destroyed_shipparts_count == shipparts.size():
		set_collision_layer_value(5,true)
	
	if not can_die and health <20 :
		health = 20 
	

func move(target:Node2D,move_time: float):
	var tween = create_tween()
	tween.tween_property(self,"global_position",target.global_position,move_time)
	
func move_in():
	can_fire = true
	move(target_pos,move_in_time)
	await get_tree().create_timer(move_in_time).timeout
	Dialogic.start("Boss Battle Sloppy 1")
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
	$HitAnimation.play("RESET")
	
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_packed(next_scene)
	#queue_free()
var has_exploded = false
func reduce_health(amount):
	health -= amount
	health_changed.emit(max_health, health)
	$HitAnimation.play("hit")
	if health<=0 and not has_exploded:
		explode()
		has_exploded = true

		
		
func reduce_health_no_blink(amount):
	health -= amount
	health_changed.emit(max_health, health)
	#$HitAnimation.play("hit")
	if health<=0 and not has_exploded :
		explode()
		has_exploded = true
	
	##signals from children for reducing health
func _on_turret_1_health_reduced(amount) -> void:
	reduce_health_no_blink(amount)
func _on_turret_2_health_reduced(amount) -> void:
	reduce_health_no_blink(amount)
func _on_turret_3_health_reduced(amount) -> void:
	reduce_health_no_blink(amount)
func _on_turret_4_health_reduced(amount) -> void:
	reduce_health_no_blink(amount)
func _on_port_1_health_reduced(amount) -> void:
	reduce_health_no_blink(amount)
func on_port_2_health_reduced(amount) -> void:
	reduce_health_no_blink(amount)
