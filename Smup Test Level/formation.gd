class_name Formation extends Path2D

@export var testing : bool = false

var player : ShipPlayer
var following : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_for_player()
	if not player:
		start_moving()
	
	
	# when in range:
func _process(delta: float) -> void:
	if player:
		##see if formation is on screen/player is in range and start moving
		if player.get_parent().global_position.y < global_position.y:
			following = true
			start_moving()
	if following:
		global_position =  player.get_parent().global_position
		
	if get_children().size() == 0:
		print("NO MORE CHILDREN")
		queue_free()
		
		
func check_for_player():
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
	
func start_moving():
	for drone_parent in get_children():
		if drone_parent is DroneParent:
			drone_parent.start()
		
