class_name RacePlayer extends Node3D #extends AnimatedSprite3D

@export var acceleration: float = 1
@export var top_speed: float = 1
var speed = 0
@export var drag = 0.95
@export var drag_off_track = 0.85

@export var turn_acceleration: float = 20
var turn_speed = 0
@export var turn_drag = 0.9


var can_move = false

var on_track = true
@export var racetracktrigger : Area3D 

func _ready():
	pass
	
	
func _process(delta):
	# check on track
	if $OnTrackRaycast3D.is_colliding():
		on_track = true
	else:
		on_track = false

	
	#  print(on_track)	#if racetracktrigger.has_overlapping_areas():
		#on_track = true
	#else:
		#on_track = false
	
	if not can_move:
		return
		
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var thrust = Input.is_action_pressed("race_thruster")
	var reverse = Input.is_action_pressed("race_reverse")
	
	#speed += input.y * acceleration * delta
	if thrust:
		speed += acceleration * delta * -1
	if reverse:
		speed += acceleration * delta
		
	if on_track:
		speed *= drag
	else: 
		speed *= drag_off_track
		
	translate(Vector3(0, 0, speed))

	
	turn_speed += input.x * remap(-speed, 0, .05, 0, turn_acceleration) * delta
	turn_speed *= turn_drag
	
	rotation_degrees.y -= turn_speed
	
	$"reunited ship".rotation_degrees.y = remap(turn_speed, -2, 2, 30, -30)
	
	#if turn_speed > .5:
		#
		##animation = "right"
		##frame = remap(abs(turn_speed), 0, 2, 0, 6)
	#elif turn_speed < -.5:
		##animation = "left"
		##frame = remap(abs(turn_speed), 0, 2, 0, 6)
	#else: 
		##animation = "default"
		##frame = 0


#func _on_area_3d_area_entered(area: Area3D) -> void:
		#if area.is_in_group("race_track"):
			#on_track = true
	#
##
##
#func _on_area_3d_area_exited(area: Area3D) -> void:
		#if area.is_in_group("race_track"):
			#on_track = false
		#
