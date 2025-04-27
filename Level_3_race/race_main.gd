extends Node3D


enum RACE_STATE {
	COUNTDOWN,
	RACING,
	FINISH	
}

var race_state: RACE_STATE = RACE_STATE.COUNTDOWN


@export var last_nearest_point_index: int = 0

@export var laps: int = 1
@export var max_laps: int = 3
@export var can_lap: bool = false
@export var last_progress_ratio = 0

@export var auto_speed = 0.02


@onready var other_racers: Array[RaceCompetitor] = [
	$Path3D/Racer1,
	$Path3D/Racer2,
	$Path3D/Racer3
]

@onready var position_label = $Camera3D/UI/PositionLabel
@onready var lap_label = $Camera3D/UI/LapLabel

@onready var player = $Ship


func _process(delta):
	# check nearest point by looping over every point and checking distance
	
	#var closest_point = find_closest_point($Path3D, player.global_position)
	# get list of points
	#var points: PackedVector3Array = $Path3D.curve.get_baked_points()
	var player_offset = $Path3D.curve.get_closest_offset($Path3D.to_local(player.global_transform.origin))
	#var closest_offset = $Path3D.curve.get_closest_offset($Path3D.transform * $Ship.global_transform.origin)
	var player_progress_ratio = player_offset / $Path3D.curve.get_baked_length()
	
	#print("player offset: ", player_progress_ratio);
	
	#var progress_ratios = []
	var position = 4
	
	# Determining position
	for i in other_racers.size():
		var r = other_racers.get(i)
		#print("racer", i," offset: ", r.progress_ratio)
		#progress_ratios.push_back(r.progress_ratio)
		if r.progress_ratio < player_progress_ratio and r.laps < laps:
			position -= 1
		
		
	# Laps 	
	if player_progress_ratio > 0.999:
		if can_lap and last_progress_ratio < player_progress_ratio:
			laps+=1
			can_lap = false
			$CanLapTimer.start()
			if laps == max_laps + 1:
				race_state = RACE_STATE.FINISH
				$Ship/CameraOffset/AnimationPlayer.play("finish")
				$Camera3D/UI/LapLabel.visible = false
				player.can_move = false
				
				$Camera3D.spectator_mode = true
				#player.reparent($Path3D/PlayerPathFollow)
			else: 
				$Ship/CameraOffset/AnimationPlayer.play("new_lap")
	
	
	#print(position)
	
	$Camera3D/UI/PositionLabel.text = str("pos. ", position, "/", 4)
	$Camera3D/UI/LapLabel.text = str("lap ", laps, "/", max_laps)


	if race_state == RACE_STATE.FINISH:
		$Path3D/PlayerPathFollow.progress += auto_speed
		player.global_position = $Path3D/PlayerPathFollow.global_position
		player.global_rotation = lerp(player.global_rotation, $Path3D/PlayerPathFollow.global_rotation, 0.3)
		

	#if player_progress_ratio > 
	
	#for i in points.size():
		#var p: Vector3 = points.get(i)
		#if p == closest_point:
			#pass
		
		
	
	#for p in points:
		#print(p)	
	
	
	#for point in $Path3D.curve.points.size():
		#pass
	#print(player)
	# points have to be in sequence
	last_progress_ratio = player_progress_ratio


func find_closest_point( # find_closest_index
  path: Path3D,
  global_pos: Vector3
):
	var curve: Curve3D = path.curve
	# transform the target position to local space
	var path_transform: Transform3D = path.global_transform
	var local_pos: Vector3 = global_pos * path_transform
	# get the nearest offset on the curve
	var closest_point: Vector3 = curve.get_closest_point(local_pos)
	return closest_point
	


func find_closest_abs_pos(
  path: Path3D,
  global_pos: Vector3
):
	var curve: Curve3D = path.curve
	# transform the target position to local space
	var path_transform: Transform3D = path.global_transform
	var local_pos: Vector3 = global_pos * path_transform
	# get the nearest offset on the curve
	var offset: float = curve.get_closest_offset(local_pos)
	# get the local position at this offset
	var curve_pos: Vector3 = curve.sample_baked(offset, true)
	# transform it back to world space
	curve_pos = path_transform * curve_pos
	return curve_pos


func _on_start_countdown_timer_timeout():
	pass
	#$Ship/CameraOffset/Camera3D/Countdown.show()
	#$Ship/CameraOffset/Camera3D/Countdown.play("default")


func _on_race_start_timer_timeout():
	race_state = RACE_STATE.RACING
	$Ship.can_move = true


func _on_can_lap_timer_timeout():
	can_lap = true
