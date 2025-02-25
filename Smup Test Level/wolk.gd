extends Sprite2D
@export var speed : float = 10
@export var range : int = 60
var player : ShipPlayer

func _ready() -> void:
	check_for_player()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#position.y += speed * delta
	
	if player:
		##see if player is in range and start moving
		if player.get_parent().global_position.y < (global_position.y + range):
			position.y += speed * delta
			
func check_for_player():
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
	
