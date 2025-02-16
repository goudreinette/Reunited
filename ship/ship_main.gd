extends Node2D


var score = 0


#@onready var start_button = $CanvasLayer/CenterContainer/Start
@onready var game_over = $CanvasLayer/CenterContainer/GameOver

@export var formation_1 : PackedScene
@export var formation_2 : PackedScene
@export var formation_3 : PackedScene
@export var formation_4 : PackedScene
@export var turret : PackedScene

@export var cloud1 : PackedScene
@export var cloud2 : PackedScene
@export var cloud3 : PackedScene

#@onready var mission_start = $CanvasLayer/CenterContainer/GameOver

# Implement here: spawning logic
@export var ring_pickup : PackedScene

func _ready():
	game_over.hide()
#	spawn_enemies()	




func random_position_just_outside_frame():
	return Vector2(
		randf_range(0, get_viewport_rect().size.x), 
		$LevelPosition/Wendla.global_position.y - get_viewport_rect().size.y
	)
	

func _process(delta):
	# Spawning logic
	if randi_range(0, 125) == 1:
		var r = ring_pickup.instantiate()
		add_child(r)
		r.global_position = random_position_just_outside_frame()
		
	if randi_range(0, 10000) == 1:
		var r = cloud1.instantiate()
		add_child(r)
		r.global_position = random_position_just_outside_frame()
	
	if randi_range(0, 10000) == 1:
		var r = cloud2.instantiate()
		add_child(r)
		r.global_position = random_position_just_outside_frame()
		
	if randi_range(0, 10000) == 1:
		var r = cloud3.instantiate()
		add_child(r)
		r.global_position = random_position_just_outside_frame()
	
	if randi_range(0, 5000) == 1:
		var r = formation_1.instantiate()
		add_child(r)
		r.global_position = random_position_just_outside_frame()
		(r as Node2D).rotation = randi_range(0, 360)
	
	if randi_range(0, 5000) == 1:
		var r = formation_2.instantiate()
		add_child(r)
		r.global_position = random_position_just_outside_frame()
		(r as Node2D).rotation = randi_range(0, 360)
		
	if randi_range(0, 5000) == 1:
		var r = formation_3.instantiate()
		add_child(r)
		r.global_position = random_position_just_outside_frame()
		(r as Node2D).rotation = randi_range(0, 360)
		
	if randi_range(0, 5000) == 1:
		var r = formation_4.instantiate()
		add_child(r)
		r.global_position = random_position_just_outside_frame()
		(r as Node2D).rotation = randi_range(0, 360)
		
	if randi_range(0, 2000) == 1:
		var r = turret.instantiate()
		add_child(r)
		r.global_position = random_position_just_outside_frame()
		
	# Boss battle 
	if Input.is_action_pressed("wilburr") and $LevelPosition/Wilburr.process_mode == PROCESS_MODE_DISABLED:
		$LevelPosition/Wilburr.process_mode = Node.PROCESS_MODE_ALWAYS
		$LevelPosition/Wilburr/AnimatedSprite/AnimationPlayer.play("wilburr in")
		$LevelPosition/Wilburr.visible = true

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


func add_score(amount):
	score += amount
	$CanvasLayer/UI.update_score(score)
