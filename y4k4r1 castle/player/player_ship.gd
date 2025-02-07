class_name Wendla extends Area2D

signal shield_changed
signal died

var explode_scene = preload("res://explosion.tscn")

enum WeaponTypes {DEFAULT, SCATTER, GATTLING}

@export var move_speed = 150
@export var cooldown = 0.25
@export var gatling_cooldown = 0.025
@export var current_weapon_type = WeaponTypes.SCATTER

@export var bullet_scene: PackedScene
#@export var bullet_scene : PackedScene
@export var max_shield = 10
var shield = max_shield:
	set = set_shield
var can_shoot = true

@onready var screensize = get_viewport_rect().size

func _ready():
	start()

func start():
	show()
	position = Vector2(screensize.x / 2, get_parent().position.y + screensize.y / 3)
	shield = max_shield
	$GunCooldown.wait_time = cooldown
	
func _process(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += input * move_speed * delta
	position = position.clamp(Vector2(8, 8), screensize-Vector2(8, 8))
	
	if input.x > 0:
		#$Ship.frame = 2
		$Ship/Boosters.animation = "right"
		$Ship.animation = "strafe_right"
	elif input.x < 0:
		#$Ship.frame = 0
		$Ship.animation = "strafe_left"
	else:
		#$Ship.frame = 1
		$Ship/Boosters.animation = "forward"
		$Ship.animation = "neutral idle"
	

	if Input.is_action_pressed("shoot"):
		#if get_parent():
			#if not $"..".playing:
				#$".."._on_start_pressed()
		shoot()

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	
	if current_weapon_type == WeaponTypes.DEFAULT:
		shoot_default()
	elif current_weapon_type == WeaponTypes.SCATTER:
		shoot_scatter()
	elif current_weapon_type == WeaponTypes.GATTLING:
		shoot_gattling()
	
	var tween = create_tween().set_parallel(false)
	tween.tween_property($Ship, "position:y", 1, 0.1)
	tween.tween_property($Ship, "position:y", 0, 0.05)
	$AudioStreamPlayer.play()

func shoot_default():
	$GunCooldown.wait_time = cooldown
	$GunCooldown.start()
	
	var b = bullet_scene.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(global_position + Vector2(0, -8), deg_to_rad(rotation))
	pass
	
func shoot_scatter():
	$GunCooldown.wait_time = cooldown
	$GunCooldown.start()
	
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(global_position + Vector2(0, -8), deg_to_rad(rotation+15))
	
	b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(global_position + Vector2(0, -8), deg_to_rad(rotation))
	
	b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(global_position + Vector2(0, -8), deg_to_rad(rotation-15))
	pass
	
func shoot_gattling():
	$GunCooldown.wait_time = gatling_cooldown
	$GunCooldown.start()
	
	var b = bullet_scene.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(global_position + $Ship/BallLeft.position + Vector2(0,-8), deg_to_rad(rotation))
	
	b = bullet_scene.instantiate()
	get_parent().get_parent().add_child(b)
	b.start(global_position + $Ship/BallRight.position + Vector2(0,-8), deg_to_rad(rotation))
	
func set_shield(value):
	shield = min(max_shield, value)
	shield_changed.emit(max_shield, shield)
	if shield <= 0:
		
		hide()
		died.emit()
		
func _on_gun_cooldown_timeout():
	can_shoot = true

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.reduce_health(4)
		$Hit.play()
		shield -= 4
