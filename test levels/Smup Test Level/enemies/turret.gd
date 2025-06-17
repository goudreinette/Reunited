extends Area2D

signal died 
signal health_reduced

@export var maxhealth : int = 20
 
@export var health : int  
var healthratio : float 
var explode_scene = preload("res://Effects/Big Explosion.tscn")
var isdead : bool = false

enum FiringPatterns {
	Continuous,
	Burst, 
	Sine,
	Rotate360
}
@export var turret_range : int = 200

@export var firing_pattern = FiringPatterns.Burst
@export var burst_time: float = 2.0
@export var cooldown_time: float = 3.0
@export var rate_of_fire: float = 0.25
@export var aim_speed = 16
@export var bullet_speed = 100.0
var player : ShipPlayer

@export var boss:Area2D



# var bullet_scene = preload("res://ship/enemies/enemy_bullet.tscn")
@export var bullet_scene : PackedScene

var is_cooling_down: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	await get_tree().create_timer(randf_range(0.0,2))
	$ShootTimer.wait_time = rate_of_fire
	$BurstTimer.wait_time = burst_time
	$CooldownTimer.wait_time = cooldown_time + randf_range(0.0,2)
	#find the player if it exists
	#so it doesnt crash while testing only the turret
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
	health = maxhealth
	
	


func _process(delta: float) -> void:
	# var look_at_angle = $Canon.get_angle_to(player.position) - deg_to_rad(90)	
	##Look at Player if he exists
	if player and not isdead:
		$Canon.rotation += ($Canon.get_angle_to(player.global_position) - deg_to_rad(90)) / aim_speed
	healthratio =  float(health) / float(maxhealth)
	
#	# Charging!
	#print($BurstTimer.time_left)
	#if not $BurstTimer.is_stopped() and $BurstTimer.time_left < 2 and not $Canon/ChargeAnimation.is_playing():
		#$Canon/ChargeAnimation.play()
	
	if health <=0 and not isdead:
		explode()
	
	# Set frame to health
	# base
	$Base.frame = remap(healthratio, 1, 0, 5, 9)
	# Turret
	$Canon.frame = remap(healthratio, 1, 0, 0, 4)
	
func reduce_health(amount):
	health -= amount
	health_reduced.emit(amount)
	#if health > 0:
	$HitAnimation.play("hit")
	
func explode():
	isdead = true
	#$AnimationPlayer.play("explode")
	#$AudioStreamPlayer2D.play()
	set_deferred("monitorable", false)
	var e = explode_scene.instantiate()
	get_tree().root.add_child(e)
	e.start(global_position)
	$CollisionShape2D.queue_free()
	died.emit(5)
	await $HitAnimation.animation_finished # Needed to 
	$"Canon/ChargeAnimation".queue_free()
		
	process_mode = Node.PROCESS_MODE_DISABLED
	
	#queue_free()

func shoot(spd):
	if boss.can_fire:
		var b = bullet_scene.instantiate()
		get_tree().root.add_child(b)
		b.start($Canon/ShootPos.global_position,$Canon.rotation,spd)
	
## in case of burst mode first wait for cooldown	
func _on_cooldown_timer_timeout() -> void:
	$Canon/ChargeAnimation.play()
	is_cooling_down = false
	$CooldownTimer.wait_time = cooldown_time ##in case of an offset


##Then the charge animation plays
func _on_charge_animation_animation_finished() -> void:
	
	shoot(bullet_speed)
	$BurstTimer.start()	
	$ShootTimer.start()

## then the burst timer starts and the shooting
##or when no burst is selected this is always playing
func _on_shoot_timer_timeout():
	if player:
		if abs(player.global_position.y - global_position.y) < turret_range and not isdead:
			if firing_pattern == FiringPatterns.Continuous:
				shoot(bullet_speed)
				$ShootTimer.start()
			elif firing_pattern == FiringPatterns.Burst:
				if not is_cooling_down:
					shoot(bullet_speed)
					$ShootTimer.start()

#	$ShootTimer.wait_time = rate_of_fire

## then when the burst timer ends the Cooldown timer starts again
func _on_burst_timer_timeout() -> void:
	is_cooling_down = true
	$CooldownTimer.start()


	
