extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	$Timer.start()
	$"Button Press".play()
	$"Button Manager/Play".disabled = true


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")
