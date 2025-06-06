extends Area2D

@export var sprays: Array[Area2D] 

var has_been_turned = false
var player_in_area = false

func _physics_process(delta: float) -> void:
	if player_in_area and has_been_turned == false:
		$PressX.visible = true
	else :$PressX.visible = false
	
	if $PressX.visible and Input.is_action_just_pressed("dialogic_default_action"):
		turn_valve()
		pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = true
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false

func turn_valve():
	$AnimationPlayer.play("turn")
	has_been_turned = true
	for i in sprays:
		i.retract()
