extends Node2D



var score = 0


#@onready var start_button = $CanvasLayer/CenterContainer/Start
@onready var game_over = $CanvasLayer/CenterContainer/GameOver

@export var port1 : Area2D 
@export var port2 : Area2D 

@export var speaker1 : Area2D 
@export var speaker2 : Area2D 

@export var lazers : Node2D 

func _ready():
	game_over.hide()
#	spawn_enemies()	
	

func _input(event):
	if event.is_action_pressed("1"):
		attack_drones()
	if event.is_action_pressed("2"):
		attack_speakers()
	if event.is_action_pressed("3"):
		attack_lazers()


func _on_enemy_died(value):
	score += value
	$CanvasLayer/UI.update_score(score)
	$Camera2D.add_trauma(0.5)
	
### ATTACK MOVES STAGE 1
## 1
func attack_drones():
	if port1 != null : port1.attack()
	if port2 != null : port2.attack()
	#if port1.attack() == "done" or port2.attack() == "done" or get_tree().create_timer(15).timeout:
		#return "done"
		#print("drones_done")	
## 2
func attack_speakers():
	if speaker1 != null : speaker1.attack()
	if speaker2 != null : speaker2.attack()
	#if speaker1.attack() == "done" or speaker2.attack() == "done" or get_tree().create_timer(15).timeout: 
		#return "done"
		#print("speakers_done")		
## 3
func attack_lazers():
	if lazers != null : lazers.shoot_lazers()
	


func _on_player_died():
#	print("game over")
#	get_tree().call_group("enemies", "queue_free")
	game_over.show()

func new_game():
	score = 0
	$CanvasLayer/UI.update_score(score)
	$Player.start()
func _on_start_pressed():
	#start_button.hide()
	new_game()
func _on_player_shield_changed() -> void:
	pass # Replace with function body.
	
