extends Node2D


var score = 0


#@onready var start_button = $CanvasLayer/CenterContainer/Start
@onready var game_over = $CanvasLayer/CenterContainer/GameOver
#@onready var mission_start = $CanvasLayer/CenterContainer/GameOver

# Implement here: spawning logic


func _ready():
	game_over.hide()
#	spawn_enemies()	
	

func _on_enemy_died(value):
	score += value
	$CanvasLayer/UI.update_score(score)
	$Camera2D.add_trauma(0.5)
	

	
func _on_player_died():
#	print("game over")
	get_tree().call_group("enemies", "queue_free")
	game_over.show()



func new_game():
	score = 0
	$CanvasLayer/UI.update_score(score)
	$Player.start()
	
	
func _on_start_pressed():
	#start_button.hide()
	new_game()
