extends Camera3D

@export var follow_target: Node3D
@export var look_target: Node3D
#@export var follow_offset = Vector3(0,0,1) 
var spectator_mode = false


func _process(delta):
	global_position = lerp(follow_target.global_position, global_position, 0.8)
	rotation_degrees.y = follow_target.rotation_degrees.y
	look_at(look_target.position)
