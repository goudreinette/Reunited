extends Node2D

var player : ShipPlayer
var following : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	check_for_player()
	if not player:
		shoot_lazers()
	
	
	# when in range:
func _process(delta: float) -> void:
	if player:
		##see if formation is on screen/player is in range and start moving
		if player.get_parent().global_position.y < global_position.y:
			if following == false :
				Dialogic.start("Take_this")
			following = true
			
	if following:
		global_position =  player.get_parent().global_position
			
func _on_timeline_ended():
	if following == true:
		shoot_lazers()
	
func check_for_player():
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
	
func shoot_lazers():
	for s in get_children():
		s.shoot()
		
