class_name RaceCompetitor extends PathFollow3D

@export var max_speed = 0.04
@export var acceleration = 0.0005
var speed = 0.0

var is_started: bool = false

@export var laps = 0

var noise = FastNoiseLite.new()


func _init():
	noise.set_seed(randi_range(0, 1000))

func _physics_process(delta: float) -> void:
	if is_started:
		$cuba_car_blue.position.x = noise.get_noise_1d(Time.get_ticks_msec() / 100) * 8.0
		
		if speed < max_speed:
			speed += acceleration + noise.get_noise_1d(Time.get_ticks_msec() / 10) / 1000
		
	#print(speed)
	progress += speed
	
	


func _on_timer_timeout():
	is_started = true
