extends Camera3D

@export var follow_target: Node3D
@export var look_target: Node3D
@export var follow_offset = Vector3(0,0,1) 

func _process(delta):
  global_position = lerp(follow_target.global_position + follow_offset, global_position + follow_offset, 0.1)
  look_at(look_target.position)
