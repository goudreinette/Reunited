extends MarginContainer

@onready var health_bar = $HealthBar

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	modulate = Color(1.0, 1.0, 1.0, 0.0)
func _on_dialogic_signal(argument:String):
	if argument == "Start":
		var tween = create_tween()
		tween.tween_property(self,"modulate", Color(1,1,1,1), 5.0)

func update_shield(max_value, value):
	health_bar.max_value = max_value
	health_bar.value = value

func _on_final_boss_health_changed(max_value, value) -> void:
	health_bar.max_value = max_value
	health_bar.value = value
	#update_shield(max_value, value)
