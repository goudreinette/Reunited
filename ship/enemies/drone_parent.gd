class_name DroneParent extends PathFollow2D


# Called when the node enters the scene tree for the first time.
@export var speed : float = 0.1
@export var ismoving : bool = false

func _ready() -> void:
	for child in get_children():
		(child as Node2D).visible = false
		child.set_process(Node.PROCESS_MODE_DISABLED)

func start():
	ismoving = true
	for child in get_children():
		(child as Node2D).visible = true
		child.set_process(Node.PROCESS_MODE_INHERIT)
	#drone = drone_scene.instantiate()
	#add_child(drone)
	

func _process(delta: float) -> void:
	if ismoving:
		progress_ratio += delta * speed
		if progress_ratio == 1:
			print("DONE, DESTROY CHILD")
			queue_free()
