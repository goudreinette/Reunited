extends Node2D

@export var scene : PackedScene
@export var UI : Control
var has_spawned = false
var player : ShipPlayer


func _ready() -> void:
	check_for_player()
	if not player:
		pass
	
	# when in range:
func _process(delta: float) -> void:
	if player:
		##see if formation is on screen/player is in range and start moving
		if player.get_parent().global_position.y < position.y and not has_spawned:
			move_to_scene()
			print("move_to_Scene")
		else: position.y = player.get_parent().global_position.y

##move the player to the starting point of the scene	
func move_to_scene():
	#scene.visible = true
#	scene.PROCESS_MODE_INHERIT
	if not has_spawned:
		UI.visible = false
		var tween = create_tween()
		#player.get_parent().levelspeed = 0
		tween.tween_property(player,"position", $ship_position.position, 1.0)
		tween.tween_callback(spawn_scene)
		has_spawned = true
		
##spawn the s
func spawn_scene():
	player.visible = false
	player
	var s = scene.instantiate()
	add_child(s)
	s.start(Vector2(0,0))

func check_for_player():
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
