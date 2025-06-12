extends Sprite2D


@export var textures: Array[Texture2D]
@export var fade_time: float = 0.5
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func show_cutscene(nr):
	visible = true
	texture = textures[nr]
	#var tween = Tween.new()
	#modulate = Color(0.0, 0.0, 0.0, 0.0)
	#tween.tween_property(self,"modulate",Color(1.0, 1.0, 1.0),fade_time)
func hide_cutscene():
	#var tween = Tween.new()
	#tween.tween_property(self,"self_modulate",Color(0.0, 0.0, 0.0, 0.0),fade_time)
	visible = false
	
func _on_dialogic_signal(argument:String):
	if argument == "hide":
		hide_cutscene()
