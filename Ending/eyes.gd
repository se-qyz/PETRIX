extends Node2D


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	$AnimatedSprite2D.play("blink")


func _on_timer_timeout() -> void:
		get_tree().change_scene_to_file("res://Ending/ending.tscn")
