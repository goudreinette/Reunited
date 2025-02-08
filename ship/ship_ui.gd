extends MarginContainer

@onready var shield_bar = $HBoxContainer/ShieldBar
@onready var score_counter = $HBoxContainer/ScoreCounter

func update_score(value):
	score_counter.display_digits(value)
	


var display_shield: float = 100
var target_shield: float = 100
var max_shield: float


func update_shield(max_value, value):
	if value < target_shield:
		$Healthbar/AnimationPlayer.play("take_damage")
	target_shield = value
	max_shield = max_value
	
	
func _process(delta):
	display_shield = lerp(display_shield, target_shield, 0.05)
	#shield_bar.max_value = max_value
	#shield_bar.value = value
	#print(display_shield)
	$Healthbar.frame = remap(display_shield, 0, max_shield, 0, 52)

	
