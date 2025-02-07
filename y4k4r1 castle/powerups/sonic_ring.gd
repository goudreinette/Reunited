extends AnimatedSprite2D


@export var magnet_range = 120

var player: Wendla

var collected: bool = false


func _ready():
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]


func _process(delta):
	if global_position.distance_to(player.global_position) < magnet_range:
		global_position = lerp(global_position, player.global_position, .1)


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player") and not collected:
		collected = true
		$AnimationPlayer.play("shrink")
		$Ring.play()
		await $Ring.finished
		queue_free()
