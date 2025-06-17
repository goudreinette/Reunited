extends Area2D

enum PickupTypes {SHIELD, SCATTER, GATTLING}
@export var CurrentType: PickupTypes
var picked_up:bool = false

@export var shield_amount: int = 5
@export var scatter_time: float = 10.0
@export var gattling_time: float = 10.0
@export var death_time: float = 10.0

var has_speed = false
@export var speed: float = 10


func _ready() -> void:
	start()
	
func start(pos:Vector2 = position,is_random = true,has_speed= false):
	position = pos
	
	$Shield.visible = false 
	$Scatter.visible = false 
	$Gattling.visible = false
	
	if is_random:
		var t:int =  randi_range(0,2)
		CurrentType = t
	
	if CurrentType == 0: $Shield.visible =true 
	elif CurrentType == 1: $Scatter.visible =true 
	elif CurrentType == 2: $Gattling.visible =true 
	await get_tree().create_timer(death_time).timeout
	queue_free()
func _physics_process(delta: float) -> void:
	if picked_up: visible =false
	if has_speed: position.y +=speed
	

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		picked_up = true
		if CurrentType == 0: area.shield_pickup(shield_amount)
		elif CurrentType == 1: area.scatter_pickup(scatter_time)
		elif CurrentType == 2: area.gattling_pickup(gattling_time)
		$Sound.play()
		await $Sound.finished
		queue_free()
