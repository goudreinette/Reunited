extends StaticBody2D


func open_door():
	$AnimatedSprite2D.play("Open")
	set_collision_layer_value(1,false)
	
func close_door():
	$AnimatedSprite2D.play("default")
	set_collision_layer_value(1,true)
