extends CharacterBody2D


@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@export var sprite_sheet: Texture2D 

var direction : Vector2 = Vector2.ZERO
@export var move_speed = 40.0
@export var next_position : Node2D



var is_moving = false
var last_pos : Vector2
var pos_dif :  Vector2

func _ready() -> void:
	if sprite_sheet != null:
		$Sprite2D.texture = sprite_sheet

func _physics_process(delta: float) -> void:
	##move with arrows
	#direction.x = Input.get_axis("ui_left", "ui_right")
	#direction.y = Input.get_axis("ui_up", "ui_down")
	#direction = direction.normalized()
	#velocity = direction * move_speed
	#move_and_slide()
	
	##move to a position
	var tween = create_tween()
	if next_position != null:
		tween.tween_property(self,"position", next_position.position, 1)
	
	
	pos_dif = position - last_pos
	last_pos = position
	direction = pos_dif.normalized()
	update_animation_parameters(direction)
	 
	##check if is moving and set animation_State
	if abs(pos_dif) > Vector2(0.005,0.005) : 
		is_moving = true
		state_machine.travel("walk")
	else: 
		is_moving = false
		state_machine.travel("idle")
	
	
	##set direction in state mashine
func update_animation_parameters(move_input : Vector2):
	#dont change direction if there is no input
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/walk/blend_position",direction)
		animation_tree.set("parameters/idle/blend_position",direction.x)



func get_direction(position : Vector2) -> Vector2:
	var pos_dif :  Vector2
	pos_dif = position - last_pos
	last_pos = position
	
	return pos_dif.normalized()
	
func get_vel(position : Vector2) -> Vector2:
	var pos_dif :  Vector2
	pos_dif = position- last_pos
	last_pos = position
	
	return pos_dif
