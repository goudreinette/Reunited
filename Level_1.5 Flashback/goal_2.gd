extends Node2D

@export var sloppy_ship :Sprite2D



func _on_area_2d_area_entered(area: Area2D) -> void:
	sloppy_ship.move_away()
