extends Area2D

signal died 

var start_pos = Vector2.ZERO
var speed = 0
var bullet_scene = preload("res://ship/enemy_bullet.tscn")
var explode_scene = preload("res://explosion.tscn")
#@export var bullet_scene : PackedScene
#@export var bullet_scene : PackedScene
var anchor
var follow_anchor = false

@onready var screensize  = get_viewport_rect().size


func start(pos):
	follow_anchor = false
	speed = 0
	position = Vector2(pos.x, -pos.y)
	start_pos = pos
	await get_tree().create_timer(randf_range(0.25, 0.55)).timeout
	var tw = create_tween().set_trans(Tween.TRANS_BACK)
	tw.tween_property(self, "position:y", start_pos.y, 1.4)
	await tw.finished
	follow_anchor = true
	$MoveTimer.wait_time = randf_range(5, 20)
	$MoveTimer.start()
	$ShootTimer.wait_time = randf_range(4, 20)
	$ShootTimer.start()
	$AnimationPlayer.play("Idle")
	
func _process(delta):
	if follow_anchor:
		position = start_pos + anchor.position
	position.y += speed * delta
	if position.y > screensize.y + 32:
		start(start_pos)

func explode():
	#speed = 0
	#$AnimationPlayer.play("explode")
	#$AudioStreamPlayer2D.play()
	#set_deferred("monitorable", false)
	#await $AnimationPlayer.animation_finished
	
	
	died.emit(5)
	var e = explode_scene.instantiate()
	get_tree().root.add_child(e)
	e.start(global_position)
	queue_free()
	

func _on_timer_timeout():
	speed = randf_range(75, 100)
	follow_anchor = false

func _on_shoot_timer_timeout():
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(position,0) 
	$ShootTimer.wait_time = randf_range(4, 20)
	$ShootTimer.start()
