extends Area2D

signal died 

var explode_scene = preload("res://smal explosion.tscn")

@export var speed : float  = 100
@export var acceleration : float = 0.25
@export var max_speed : float = 100
@export var aim_speed = 16

@export var health : int = 1 


var target : Node2D


func _ready():
	##find the player if it exists
	##so it doesnt crash while testing only the turret
	var enemies = get_tree().get_nodes_in_group("enemies")
	 # get spawn nodes
	# assume the first spawn node is closest
	if enemies.size() > 0:
		var nearest_enemy = enemies[0]

		# look through spawn nodes to see if any are closer
		for enemy in enemies:
			if enemy.global_position.distance_to(global_position) < nearest_enemy.global_position.distance_to(global_position):
				if enemy.process_mode != PROCESS_MODE_DISABLED:
					nearest_enemy = enemy

		target = nearest_enemy
		

func start(pos,rot):
	position = pos
	rotation = rot
	
	
func _process(delta):
	speed = lerp(speed, max_speed, acceleration)
	position -= Vector2(0, speed * delta).rotated(rotation)
	
	if health <=0:
		explode()
	
	if target and is_instance_valid(target):
		rotation += (get_angle_to(target.global_position) + deg_to_rad(90)) / aim_speed
	
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		explode()
		area.explode()
	#if area.name == "Player":
		#explode()
		#area.shield -= 1

func reduce_health(amount):
	health -= amount

func explode():
	#speed = 0
	#$AnimationPlayer.play("explode")
	#set_deferred("monitorable", false)
	#await $AnimationPlayer.animation_finished
	died.emit(5)
	##spawn explosion
	var e = explode_scene.instantiate()
	get_tree().root.add_child(e)
	e.start(position)
	##delete itself
	queue_free()


func _on_deathtimer_timeout() -> void:
	explode()
	pass # Replace with function body.
