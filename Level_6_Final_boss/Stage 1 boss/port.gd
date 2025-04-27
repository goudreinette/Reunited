extends Area2D


signal died 
@export var maxhealth : int = 5
@export var health : int  
var healthratio : float 
var explode_scene = preload("res://Effects/Big Explosion.tscn")
var isdead : bool = false

var player : ShipPlayer

var is_open = false

##formatie
@export var wait_time: float = 10


@export var drone_scene : PackedScene
@export var spawn_delay: float = 0.3
@export var move_time: float = 2.0
@export var rows: int = 3
@export var ships_per_row: int = 3
@export var row_spacing: float = 20.0
@export var col_spacing: float = 30.0
@export var global_formation_offset : Vector2 = Vector2(50,100)
##voor de formatie

func _ready() -> void:
	$WaitTimer.wait_time = wait_time
	#find the player if it exists so it doesnt crash while testing only the turret
	var nodes_in_player_group = get_tree().get_nodes_in_group("Player")
	if nodes_in_player_group.size() > 0:
		player = nodes_in_player_group[0]
	health = maxhealth

func _process(delta: float) -> void:
	##setting the right frame 
	##ADD ANIMATION
	if not is_open: $Port.frame = 0 
	else: $Port.frame = 1 
	if isdead: $Port.frame = 2
	

	
	
	#temporary way of spawning
	#if Input.is_action_just_pressed("shoot"):
		#attack()

func reduce_health(amount):
	health -= amount
	if health > 0:
		$HitAnimation.play("hit")
	else: explode()
	
func explode():
	isdead = true
	$Port.frame = 2
	#$AnimationPlayer.play("explode")
	#$AudioStreamPlayer2D.play()
	set_deferred("monitorable", false)
	var e = explode_scene.instantiate()
	get_tree().root.add_child(e)
	e.start(global_position)
	
	died.emit(5)
	await $HitAnimation.animation_finished # Needed to 
	#   await $Canon/ChargeAnimation.animation_finished
	process_mode = Node.PROCESS_MODE_DISABLED
	
	#queue_free()
	
	


func attack():
	var total_rows = rows
	var ships_spawned = 0

	if not isdead: for row in range(total_rows):
		is_open = true ## deurtje open
		var offset = 0
		if row % 2 == 1: offset = row_spacing/2# oneven getallen oftewel rij 2 krijgt offset

		for col in range(ships_per_row if row != 1 else ships_per_row - 1):
			await get_tree().create_timer(spawn_delay).timeout
			
			if not isdead: spawn_ship_with_delay(row, col, offset)
			ships_spawned += 1
	is_open = false ## deurtje dicht

func spawn_ship_with_delay(row: int, col: int, offset: float) -> void:
	
	var ship = drone_scene.instantiate()
	var rot = PI  #180 graden draaien
	var target_pos : Vector2
	# Bereken nieuwe positie op basis van rij en kolom
	target_pos.x += (col * col_spacing) + offset
	target_pos.y += (row - 1) * row_spacing  # Rij 1: y=-1, Rij 2: z=0, Rij 3: z=1
	get_tree().root.add_child(ship)
	ship.start(global_position,rot,target_pos+global_formation_offset,move_time)
	
#func _on_wait_timer_timeout() -> void:
	#if not isdead:
		#attack()
