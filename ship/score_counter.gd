extends HBoxContainer

var digit_coords = {
	1: Vector2(0, 0),
	2: Vector2(8, 0),
	3: Vector2(16, 0),
	4: Vector2(24, 0),
	5: Vector2(32, 0),
	6: Vector2(0, 8),
	7: Vector2(8, 8),
	8: Vector2(16, 8),
	9: Vector2(24, 8),
	0: Vector2(32, 8)
}

func _ready():
	display_digits(000)


var displayed_score: float = 0
var target_score: float = 0

func _process(delta):
	displayed_score = lerp(displayed_score, target_score, 0.1)
	var s = "%08d" % round(displayed_score)
	for i in 8:
		get_child(i).texture.region = Rect2(digit_coords[int(s[i])], Vector2(8, 8))
	#print(target_score, displayed_score)
	if abs(target_score - displayed_score) > 2:
		modulate = Color.GOLD
	else:
		modulate = Color.WHITE
	

func display_digits(n):
	#$AnimationPlayer.play("highlight")
	target_score = n
