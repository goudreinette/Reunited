extends Area2D

@export var player: Area2D
@export var Player_stuck_pos: Node2D
@export var sloppy_trigger: Area2D
@export var screen_pos: Node2D

@export var next_level: PackedScene

@export var move_in_time: float = 3.0
@export var player_in_net: bool = false


var has_moved = false
var to_next_level_has_been_called = false

### Dialogic ###
@export var convo_1 : String = "Wormhole 2"
@export var convo_2 : String = "Wormhole 3"


var sloppy_callable = false


func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	#Dialogic.timeline_ended.connect(_on_timeline_ended)
	await get_tree().create_timer(5).timeout
	sloppy_callable = true

func _physics_process(delta: float) -> void:
	if player_in_net:
		player.global_position = Player_stuck_pos.global_position
		player.shield = 30
		player.show_boosters = false
		
		Dialogic.start(convo_2)
		
		if Input.is_action_just_pressed("Level trigger q"):
			to_next_level_has_been_called = true
			get_tree().change_scene_to_packed(next_level)
			
			
	if Input.is_action_just_pressed("Level trigger q") and sloppy_callable and not to_next_level_has_been_called:
		move_to_screen()
		has_moved = true
		Dialogic.start(convo_1)
	


func move_to_screen():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",screen_pos.position,move_in_time)
	#tween.tween_callback(deploy_net)

func _on_dialogic_signal(argument:String):
	if argument =="net":
		deploy_net()

func deploy_net():
	$Net.deploy_net()

func _on_net_area_entered(area: Area2D) -> void:
		if area.is_in_group("Player"):
			player_in_net = true


#func to_next_level():
	#await get_tree().create_timer(6).timeout
	#get_tree().change_scene_to_packed(next_level)
