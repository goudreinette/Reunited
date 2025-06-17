extends Node2D


#@export var levelpos : int = 0
@export var levelspeed : float = 30
var current_levelspeed 
@export var goal1: Node2D
@export var goal2: Node2D

var current_goal: Node2D


func _ready():
	current_levelspeed = levelspeed
	current_goal = goal1
	Dialogic.signal_event.connect(_on_dialogic_signal)
func _on_dialogic_signal(argument:String):
	if argument =="Move_Away":
		current_goal = goal2
		print("move_away")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_goal != null and current_goal.global_position.y > global_position.y :
		current_levelspeed = 0
	else: current_levelspeed = levelspeed
	
	position.y -= current_levelspeed*delta
	
