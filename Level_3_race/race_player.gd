class_name RacePlayer extends Camera3D

@export var acceleration: float = 0.2
@export var top_speed: float = 1

var speed = 0
@export var drag = 0.9

func _ready():
	pass
	
func _process(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	speed += input.y * acceleration * delta
	speed *= drag
	
	translate(Vector3(0, 0, speed))
	#global_position.z += speed
	rotation_degrees.y -= input.x * .5
