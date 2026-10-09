extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		body.take_heal(100)
		queue_free()
		$AudioStreamPlayer2D.play()
