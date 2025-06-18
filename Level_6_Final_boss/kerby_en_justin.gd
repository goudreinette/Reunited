extends Node2D

@export var justin_target: Node2D
@export var kerbie_target: Node2D

#func _ready() -> void:
	#move_in_both()
	#
	#pass
	
func move_in_both():
	$SmallJustin.move_to(justin_target)
	$SmallKerbie.move_to(kerbie_target)
	await  get_tree().create_timer(3.0).timeout
	Dialogic.start("Boss battle Rescue")
