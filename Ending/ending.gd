extends Node2D


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	pass


func _on_timer_timeout() -> void:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
