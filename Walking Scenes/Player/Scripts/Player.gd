class_name Player extends CharacterBody2D

##movement
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
@export var move_speed : float = 40.0
##vars for dashing movement
@export var dash_speed: float = 120.0
var is_dashing: bool = false
var can_dash: bool = true

##animation states
var state : String = "idle" 

##vars for falling state
var is_falling: bool = false
var above_pit: bool = false
var is_dead: bool = false

##setting the respawn point
@export var respawnnode : Node2D
var respawnpoint: Vector2

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
##setting the next scene to load.
@export var scene_to_load: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if respawnnode : respawnpoint = respawnnode.position 
	else : respawnpoint = Vector2(0,0)
	#Dialogic.start("timeline")
	
func _process(delta: float) -> void:
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	direction = direction.normalized()
	
	if not is_dead and not is_falling:
		if is_dashing == true: 
			velocity = cardinal_direction * dash_speed
		else: 
			velocity = direction * move_speed
	else : velocity *= 0.9
	#if  is_falling : velocity = Vector2(0,0)
	if SetState() || SetDirection()== true:
		update_animation()
	
	if Input.is_action_just_pressed("dash") and can_dash: 
		is_dashing = true 
		$"DashingLines".visible = true
		$DashTimer.start()
		can_dash = false
		$DashRegenTimer.start()

	if above_pit and not is_dashing:
		if not is_falling and not is_dead :	
			animation_player.play("falling")
			print("fall start")
			is_falling = true
		
		
func  _physics_process(delta ) :
	move_and_slide()

func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	if new_dir == cardinal_direction:
		return false
	cardinal_direction = new_dir
	
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true 
	
func SetState() -> bool:
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	if is_falling : new_state = "falling"
	
	if new_state == state:
		return false
	state =	new_state
	return true
	
func update_animation() -> bool:
	animation_player.play(state + "_" + anim_direction())
	return true

func anim_direction() -> String:
	
	if cardinal_direction == Vector2.DOWN or direction == Vector2.ZERO:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else: 
		return "side"
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	#scene_to_load.instantiate()
	get_tree().change_scene_to_file("res://ship/ship_main.tscn")
	
	

func _on_pit_body_entered(body: Node2D) -> void:
	above_pit = true
	
func _on_pits_body_exited(body: Node2D) -> void:
	above_pit = false



func dead() :
	is_dead = true
	visible = false
	$DeathTimer.start()
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "falling" :
			is_falling = false
			dead()

func _on_death_timer_timeout() -> void :
	if is_dead :
		position = respawnpoint
		is_dead = false
		above_pit = false
		visible = true
		animation_player.play("idle_down")
		state = "idle"

func _on_dash_timer_timeout() -> void:
	$"DashingLines".visible = false
	is_dashing = false
	
func _on_dash_regen_timer_timeout() -> void:
	can_dash = true



			
