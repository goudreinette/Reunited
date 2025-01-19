extends Area2D

signal died 

var explode_scene = preload("res://explosion.tscn")

@export var speed = -50
@export var aim_speed = 16

@export var health : int = 1 


var player : ShipPlayer


func _ready():
	##find the player if it exists
	##so it doesnt crash while testing only the turret
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
		

func start(pos,rot):
	position = pos
	rotation = rot
	
	
func _process(delta):
	position += Vector2(0, speed * delta).rotated(rotation)
	
	if health <=0:
		explode()
	
	if player:
		rotation += (get_angle_to(player.global_position) + deg_to_rad(90)) / aim_speed
	
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.name == "Player":
		explode()
		area.shield -= 1

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
