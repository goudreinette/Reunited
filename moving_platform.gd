extends Path2D

@export var loop = true
@export var speed = 2.0
@export var speed_scale = 1.0

@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer


func _ready():
	if not loop:
		animation.play("path")
		animation.speed_scale = speed_scale
		set_process(false)
	
func _process(delta: float) -> void:
	path.progress += speed
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:	
		body.get_parent().remove_child(body)
		add_child(body)

		#body.get_parent().remove_child(body)
		$PathFollow2D.add_child(body)
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player :
		#$PathFollow2D/RemoteTransform2D.remote_path = TYPE_NIL
		pass
