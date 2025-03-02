extends Area2D


signal died


@export var position_switch_timer = 3
@export var bullet : PackedScene

@export var health : int = 2
@export var explosion_scene : PackedScene

var player : ShipPlayer
var target_pos : Vector2
var firing : bool
var in_range = false

func _ready():
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if not nodes_in_player_group.is_empty():
		player = nodes_in_player_group[0]
	
	$NewPositionTimer.wait_time = position_switch_timer
	new_random_position()
	
	
func _process(delta):
	position = lerp(position, target_pos, .03125)
	if position.distance_to(target_pos) < 2 and $FiringTimer.is_stopped():
		if in_range: 
			$FiringTimer.start()

func _on_new_position_timer_timeout():
	new_random_position()
	firing = false
	$FiringTimer.stop()
	
func new_random_position():
	target_pos = Vector2(
		randi_range(20, 240-20),
		randi_range(20, 40)
	)

func _on_firing_timer_timeout():
	var b: Node2D = bullet.instantiate()
	get_tree().get_root().add_child(b)
	#player.get_parent().add_child(b)
	b.rotation = deg_to_rad(180)
	b.global_position = $FirePositionLeft.global_position
	
	b = bullet.instantiate()
	#player.get_parent().add_child(b)
	get_tree().get_root().add_child(b)
	b.rotation = deg_to_rad(180)
	b.global_position = $FirePositionRight.global_position


func reduce_health(amount):
	health -= amount
	$HitAnimation.play("hit")
	if health<=0 :
		explode()

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
	var e = explosion_scene.instantiate()
	get_tree().get_root().add_child(e)
	e.start(global_position)
	queue_free()
