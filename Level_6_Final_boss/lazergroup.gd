extends Node2D


func shoot_lazers():
	for s in get_children():
		s.shoot()
		
