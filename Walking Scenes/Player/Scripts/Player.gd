class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var move_speed : float = 30.0
var state : String = "idle" 

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D


@export var scene_to_load: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("timeline")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	direction = direction.normalized()
	velocity = direction * move_speed
	
	if SetState() || SetDirection()== true:
		update_animation()
	pass
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
	if new_state == state:
		return false
	state =	new_state
	return true
	
	
func update_animation() -> bool:
	
	animation_player.play(state + "_" + anim_direction())
	
	return true
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else: 
		return "side"
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entered")
	#scene_to_load.instantiate()
	get_tree().change_scene_to_file("res://main.tscn")
	
