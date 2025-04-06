extends Label


@onready var player  = $"../"
func _process(delta: float) -> void:
	if player.detected:
		self.visible = true
	pass
