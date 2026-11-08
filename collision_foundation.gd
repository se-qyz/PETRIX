extends Node2D


func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "flappy":
		get_tree().reload_current_scene()
