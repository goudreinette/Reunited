extends Area2D

@export var max_health = 100
@export var health = max_health

@export var rocket: PackedScene

func _on_area_entered(area):
	pass


func _on_animated_sprite_frame_changed():
	if $AnimatedSprite.frame % 48 == 0:
		var r = rocket.instantiate()
		get_parent().get_parent().add_child(r)
		r.start($AnimatedSprite/FirePositionLeft.global_position + Vector2(0,-8), deg_to_rad(rotation))
	if $AnimatedSprite.frame % 48 == 24:
		var r = rocket.instantiate()
		get_parent().get_parent().add_child(r)
		r.start($AnimatedSprite/FirePositionRight.global_position + Vector2(0,-8), -deg_to_rad(rotation))


func explode():
	$AnimatedSprite/AnimationPlayer.play("hit")

func reduce_health(amount):
	$AnimatedSprite/AnimationPlayer.play("hit")
