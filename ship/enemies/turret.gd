extends Area2D

signal died 

@export var maxhealth : float = 5 
var health : float  
var healthratio : float 

enum FiringPatterns {
	Continuous,
	Burst, 
	Sine,
	Rotate360
}
@export var turret_range : int = 200

@export var firing_pattern = FiringPatterns.Burst
@export var burst_time = 2.0
@export var cooldown_time = 2.0
@export var rate_of_fire = 0.25
@export var aim_speed = 16
var player : ShipPlayer



# var bullet_scene = preload("res://ship/enemies/enemy_bullet.tscn")
@export var bullet_scene : PackedScene

var is_cooling_down: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ShootTimer.wait_time = rate_of_fire
	$BurstTimer.wait_time = burst_time
	$CooldownTimer.wait_time = cooldown_time
	#find the player if it exists
	#so it doesnt crash while testing only the turret
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
	health = maxhealth


func _process(delta: float) -> void:
	# var look_at_angle = $Canon.get_angle_to(player.position) - deg_to_rad(90)	
	##Look at Player if he exists
	if player:
		$Canon.rotation += ($Canon.get_angle_to(player.global_position) - deg_to_rad(90)) / aim_speed
	
	healthratio = health/maxhealth
	
	if health <=0:
		explode()
	
	print(healthratio)
	
func reduce_health(amount):
	health -= amount
func explode():
	#$AnimationPlayer.play("explode")
	#$AudioStreamPlayer2D.play()
	set_deferred("monitorable", false)
	died.emit(5)
	#await $AnimationPlayer.animation_finished
	queue_free()

func shoot():
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start($Canon/ShootPos.global_position,$Canon.rotation)
	

func _on_shoot_timer_timeout():
	if abs(player.global_position.y - global_position.y) < turret_range:
		if firing_pattern == FiringPatterns.Continuous:
			shoot()
			$ShootTimer.start()
		elif firing_pattern == FiringPatterns.Burst:
			if not is_cooling_down:
				shoot()
				$ShootTimer.start()
	
#	$ShootTimer.wait_time = rate_of_fire


func _on_burst_timer_timeout() -> void:
	is_cooling_down = true
	$CooldownTimer.start()


func _on_cooldown_timer_timeout() -> void:
	is_cooling_down = false
	$BurstTimer.start()
	$ShootTimer.start()
