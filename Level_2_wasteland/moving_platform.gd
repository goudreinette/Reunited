extends Path2D

@export var loop = true
@export var speed = 2.0
@export var speed_scale = 1.0

@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer

var player : Player
var player_on_platform = false

var last_pos : Vector2
var pos_dif :  Vector2



func _ready():
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
	
	if not loop:
		animation.play("path")
		animation.speed_scale = speed_scale
	last_pos = position
func _process(delta: float) -> void:
	
	path.progress += speed
	pos_dif = $Area2D.global_position- last_pos
	#pos_dif.x = $Area2D.global_position.x - last_pos.x 
	
	last_pos = $Area2D.global_position
#	print(pos_dif)
	if player_on_platform:
		player.position+=pos_dif
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_on_platform = true
		player.above_platform = true
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_on_platform = false
		player.above_platform = false
