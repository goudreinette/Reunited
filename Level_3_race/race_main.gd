extends Node3D


enum RACE_STATE {
	COUNTDOWN,
	RACING,
	FINISH	
}

var race_state: RACE_STATE = RACE_STATE.COUNTDOWN




func _on_start_countdown_timer_timeout():
	pass
	#$Ship/CameraOffset/Camera3D/Countdown.show()
	#$Ship/CameraOffset/Camera3D/Countdown.play("default")


func _on_race_start_timer_timeout():
	race_state = RACE_STATE.RACING
	$Ship.can_move = true
