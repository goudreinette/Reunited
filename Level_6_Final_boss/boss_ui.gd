extends MarginContainer

@onready var health_bar = $HealthBar



func update_shield(max_value, value):
	health_bar.max_value = max_value
	health_bar.value = value

func _on_final_boss_health_changed(max_value, value) -> void:
	health_bar.max_value = max_value
	health_bar.value = value
