extends Sprite2D


func _on_card_area_body_entered(body: Node2D) -> void:
	if body is Player :
		body.has_card = true
		body.ui_card.visible = true
		visible = false
		$Item.play()
		
		


func _on_item_finished():
	queue_free()
