extends Area2D

@export var speed = -50
@export var aim_speed = 16
var player : ShipPlayer


func _ready():
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
		

func start(pos,rot):
	position = pos
	rotation = rot
	#find the player if it exists
	#so it doesnt crash while testing only the turret
	
	
	
func _process(delta):
	#position +=  Vector2(cos(_rot) ,sin(_rot) ) * 
	position += Vector2(0, speed * delta).rotated(rotation)
	if player:
		rotation += (get_angle_to(player.position) + deg_to_rad(90)) / aim_speed
	
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.name == "Player":
		explode()
		area.shield -= 1

func explode():
	speed = 0
	#$AnimationPlayer.play("explode")
	$AudioStreamPlayer2D.play()
	#set_deferred("monitorable", false)
	#died.emit(5)
	#await $AnimationPlayer.animation_finished
	await $AudioStreamPlayer2D.finished
	queue_free()
