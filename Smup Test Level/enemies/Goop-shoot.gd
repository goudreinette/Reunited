extends AnimatedSprite2D

signal died 


enum FiringPatterns {
	Single
}
@export var range : int = 50
@export var firing_pattern = FiringPatterns.Single
@export var rate_of_fire = 2
var player : Player
var angle_to_player: float 
var player_in_range


# var bullet_scene = preload("res://ship/enemies/enemy_bullet.tscn")
@export var bullet_scene : PackedScene

var is_cooling_down: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ShootTimer.wait_time = rate_of_fire
	#find the player if it exists
	#so it doesnt crash while testing only the turret
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]

	
	


func _process(delta: float) -> void:
	##check angle to Player if he exists
	if player :
		angle_to_player = get_angle_to(player.global_position) 

func shoot():
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start($ShootinPosition.global_position ,player.position, 2)
	

func _on_shoot_timer_timeout():
	if player:
		if abs(player.global_position.y - global_position.y) < range:
			if firing_pattern == FiringPatterns.Single:
				shoot()
				$ShootTimer.start()

#	$ShootTimer.wait_time = rate_of_fire
