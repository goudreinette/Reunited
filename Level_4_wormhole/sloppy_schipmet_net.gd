extends Area2D

@export var player: Area2D
@export var Player_stuck_pos: Node2D
@export var sloppy_trigger: Area2D
@export var screen_pos: Node2D

@export var next_level: PackedScene

@export var move_in_time: float = 3.0
@export var player_in_net: bool = false

var has_moved = false
var to_next_level_has_been_called = false

func _physics_process(delta: float) -> void:
	if sloppy_trigger.player_in_range ==true and has_moved == false:
		move_to_screen()
		has_moved = true
		
	if player_in_net:
		
		player.global_position = Player_stuck_pos.global_position
		player.shield = 30
		player.show_boosters = false
	
		if to_next_level_has_been_called == false:
			to_next_level()
			to_next_level_has_been_called = true
		
		
func deploy_net():
	$Net.deploy_net()
func move_to_screen():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",screen_pos.position,move_in_time)
	tween.tween_callback(deploy_net)

func _on_net_area_entered(area: Area2D) -> void:
		if area.is_in_group("Player"):
			player_in_net = true
func to_next_level():
	await get_tree().create_timer(6).timeout
	get_tree().change_scene_to_packed(next_level)
