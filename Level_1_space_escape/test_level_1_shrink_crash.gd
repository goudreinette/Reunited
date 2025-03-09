extends Node2D


func _ready():
	$AnimatedSprite2D.play("normal")
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hit":
		$AnimationPlayer.play("crash")
		$AnimatedSprite2D.play("spin")
	if anim_name == "crash":
		$AnimatedSprite2D.visible = false
		$"Explosion impact".play("impact")


# Ship hit
func _on_ship_explosion_animation_finished():
	$"AnimatedSprite2D/Ship explosion".play("fire")

func _on_area_2d_area_entered(area):
	$AnimationPlayer.play("hit")
	$EnemyBullet.queue_free()
	$AnimatedSprite2D/Boosters.queue_free()
	$"AnimatedSprite2D/Ship explosion".play("hit")



# Crash on planet
func _on_explosion_impact_animation_finished():
	$"Explosion impact".play("fire")
