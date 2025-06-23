extends Area2D

@export var characters : Array[CharacterBody2D] = []
@export var move_time: float = 3
@export var next_level: PackedScene
@export var dialogue:String = "Ship_fixed"

var is_talking = false
var player_inside = false

var can_go_to_next_scene: bool = false

func _ready():
	$"Press X".visible = false
	$MoveTimer.wait_time = move_time
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true
		if not x_pressed:
			$"Press X".visible = true
		
func _on_body_exited(body: Node2D) -> void:
	$"Press X".visible = false
	player_inside = false

var x_pressed = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dialogic_default_action") and player_inside and x_pressed == false :
		start_cutscene()
		x_pressed = true
		
	if can_go_to_next_scene and event.is_action_pressed("Level trigger q"):
		get_tree().change_scene_to_packed(next_level)


func start_cutscene():
	$MoveTimer.start()
	for i in characters:
		i.move_to(i.next_position.position,move_time)
	
func _on_move_timer_timeout() -> void:
	if not is_talking: 
		Dialogic.start(dialogue)
		is_talking = true
	
### for going to the next scene
func _on_timeline_ended():
	if is_talking:
		can_go_to_next_scene = true
		
	
