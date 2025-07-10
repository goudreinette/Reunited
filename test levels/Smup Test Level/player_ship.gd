class_name ShipPlayer extends Area2D

signal shield_changed
signal died
var is_dead = false
var explode_scene = preload("res://Effects/Big Explosion.tscn")

enum WeaponTypes {DEFAULT, SCATTER, GATTLING}

@export var speed = 150
@export var cooldown = 0.25
@export var gatling_cooldown = 0.025
@export var current_weapon_type = WeaponTypes.SCATTER

@export var weapon_disabled = false
@export var respawn_time: float = 3.0


@export var bullet_scene: PackedScene
#@export var bullet_scene : PackedScene
@export var max_shield = 10
var shield_percentage:float
var low_health: bool = false


var shield = max_shield:
	set = set_shield
var in_lazer = false

var can_shoot = true


var barelling = false


@onready var screensize = get_viewport_rect().size


@export var show_boosters: bool = true

func _ready():
	start()

func start():
	show()
	position = Vector2(screensize.x / 2, screensize.y - 32)
	shield = max_shield
	$GunCooldown.wait_time = cooldown
	
func _process(delta):


	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += input * speed * delta
	position = position.clamp(Vector2(8, 8), screensize-Vector2(8, 8))
	
	if recharching_shield:
		if shield == max_shield:
			recharching_shield = false
		else:
			shield+= 1
	
	shield_percentage = (shield / max_shield)*100
	if shield_percentage<33:
		low_health = true
		
	
	if not barelling:
		if input.x > 0:
			#$Ship.frame = 2
			$AnimatedSprite2D.animation = "right"
			$Boosters.animation = "right"
		elif input.x < 0:
			#$Ship.frame = 0 
			$AnimatedSprite2D.animation = "left"
			$Boosters.animation = "left"
		else:
			#$Ship.frame = 1
			$AnimatedSprite2D.animation = "normal"
			$Boosters.animation = "forward"	
	
	if Input.is_action_just_pressed("dodge"):
		barelling = true
		$AnimatedSprite2D.play("barrel roll")
		$DodgeRoll.play()
	
		
	if Input.is_action_pressed("shoot") and not weapon_disabled:
		#$AnimatedSprite2D.animation = "barrel roll"
		
		#if get_parent():
			#if not $"..".playing:
				#$".."._on_start_pressed()
		shoot()
	##damage in lazer
	if in_lazer:
		$HitAnimation.play("hit")
		shield -=0.5
	
	if show_boosters == false:
		$Boosters.visible = false

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
	b.start(global_position + Vector2(0, -8), deg_to_rad(rotation))
	pass
	
func set_shield(value):
	if not barelling :
		shield = min(max_shield, value)
		shield_changed.emit(max_shield, shield)
	
	if shield <= 0:
		if is_dead == false :
			var e = explode_scene.instantiate()
			get_tree().root.add_child(e)
			e.start(global_position)
			hide()
			#died.emit()
			_respawning()
			is_dead = true
			$Doodgaan.play()

			
var recharching_shield = false
func _respawning():
	$HitAnimation.play("Blinking")
	await get_tree().create_timer(respawn_time).timeout
	$HitAnimation.play("RESET")
	recharching_shield = true
	is_dead = false
	

func _on_gun_cooldown_timeout():
	can_shoot = true

func _on_area_entered(area):
	if not recharching_shield:
		if area.is_in_group("enemies"):
			area.reduce_health(4)
			$Hit.play()
			shield -= 4
		if area.is_in_group("Angler"):
			shield -= 100
			#$Hit.play()
			print("angler hit")
			
		if area.is_in_group("astroids"):
			area.reduce_health(4)
			area.explode()
			$Hit.play()
			shield -= 8					
			
func _on_animated_sprite_2d_animation_finished():
	if barelling:
		barelling = false

###PICKUPS###


func shield_pickup(amt):
	shield += amt
	if shield > max_shield: shield = max_shield

func scatter_pickup(time):
	current_weapon_type = 1
	await get_tree().create_timer(time).timeout
	current_weapon_type = 0
		
func gattling_pickup(time):
	current_weapon_type = 2
	await get_tree().create_timer(time).timeout
	current_weapon_type = 0
	pass
