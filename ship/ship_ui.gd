extends MarginContainer

@onready var shield_bar = $HBoxContainer/ShieldBar
@onready var score_counter = $HBoxContainer/ScoreCounter

func update_score(value):
	score_counter.display_digits(value)
	

func update_shield(max_value, value):
	shield_bar.max_value = max_value
	shield_bar.value = value
	print(value, max_value)
	$Healthbar.frame = remap(value, 0, max_value, 0, 52)
