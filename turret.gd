extends Area2D

signal died 
@export var rate_of_fire = 1.0
@export var aim_speed = 16
var player : ShipPlayer

var bullet_scene = preload("res://ship/enemy_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ShootTimer.wait_time = rate_of_fire
	#find the player if it exists
	#so it doesnt crash while testing only the turret
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# var look_at_angle = $Canon.get_angle_to(player.position) - deg_to_rad(90)	
	if player:
		$Canon.rotation += ($Canon.get_angle_to(player.position) - deg_to_rad(90)) / aim_speed
	#$Canon.rotation += 0.1*delta
	#$Canon.look_at(player.position) 
	#$Canon.rotation -= deg_to_rad(90)
	
	
	pass
	
	
func explode():
	#$AnimationPlayer.play("explode")
	#$AudioStreamPlayer2D.play()
	set_deferred("monitorable", false)
	died.emit(5)
	##await $AnimationPlayer.animation_finished
	queue_free()

func _on_shoot_timer_timeout():
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start($Canon/ShootPos.global_position,$Canon.rotation)

	$ShootTimer.start()
#	$ShootTimer.wait_time = rate_of_fire
