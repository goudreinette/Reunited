extends Area2D


func _ready() -> void:
	scale = Vector2(0.1,0.1)

func deploy_net():
	$AnimationPlayer.play("Deploy")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Deploy":
		$AnimationPlayer.play("swing")
		
