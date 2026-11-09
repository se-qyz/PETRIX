extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()



func _on_timer_timeout() -> void:
	$LoadingBar1/TextureProgressBar.value = 2



func _on_loading_bar_2_timeout() -> void:
	$LoadingBar1/TextureProgressBar.value = 3


func _on_loading_bar_3_timeout() -> void:
	$LoadingBar1/TextureProgressBar.value = 4


func _on_loading_bar_4_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")
