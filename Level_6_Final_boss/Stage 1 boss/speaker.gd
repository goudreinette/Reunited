extends Area2D

signal died 

@export var maxhealth : int = 5 
@export var health : int  
var healthratio : float 
var explode_scene = preload("res://Effects/Big Explosion.tscn")
var isdead : bool = false

@export var bullet_scene : PackedScene
@export var bullet_amount : float = 50
@export var bullet_speed = 100
@export var shoot_pos: Node2D
@export var wait_time_1 = 3.0
@export var wait_time_2 = 3.0


@export var attack_pos : Node2D 
@export var wait_pos : Node2D
@export var move_time : float = 2.0

var hover_shake = HoverShake2D.new()


func _ready() -> void:
#	$Timer.wait_time = wait_time
	hover_shake.init(self,"up",1,0,2)

func reduce_health(amount):
	health -= amount
	$HitAnimation.play("hit")
	if health<=0 :
		explode()


func explode():
	#get_parent().speed
	#$AnimationPlayer.play("explode")
	#$AudioStreamPlayer2D.play()
	#set_deferred("monitorable", false)
	#await $AnimationPlayer.animation_finished
	$HitAnimation.play("RESET")
	died.emit(5)
	##spawn explosion
	var e = explode_scene.instantiate()
	get_parent().get_parent().get_parent().add_child(e)
	e.start(global_position)
	queue_free()


func _process(delta):
	hover_shake.update(delta)
	#if Input.is_action_just_pressed("Test"):
		#attack()

func half_circle_shot(scn,amt,spd):
	for n in amt:
		var b = scn.instantiate()
		get_tree().root.add_child.call_deferred(b)
		## PI = 180 graden 
		var d = PI/amt
		
		b.start(shoot_pos.global_position, -PI/2 + n * d,spd, false) #PI/2 om hem een offset van 90 graden te geven
		$BigSpeakers.play()

func shoot():
	half_circle_shot(bullet_scene,bullet_amount,bullet_speed)

func move_to(next_pos : Vector2, time):
	var tween = create_tween()
	if next_pos != null:
		tween.tween_property(self,"position", next_pos, time)
	
func attack():
	move_to(attack_pos.global_position, move_time)
	await get_tree().create_timer(wait_time_1).timeout ### here should be a charging animation
	shoot()
	await get_tree().create_timer(wait_time_2).timeout ### here should be a charging animation
	move_to(wait_pos.global_position, move_time)
	pass


#func hover():
	#position.y = base_position.y + sin(time_passed * hover_speed_y) * hover_amplitude_y
	#position.x = base_position.x + cos(time_passed * hover_speed_x) * hover_amplitude_x

#func _on_timer_timeout() -> void:
	#half_circle_shot(bullet_scene,bullet_amount,bullet_speed)
