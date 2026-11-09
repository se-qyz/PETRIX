extends Node2D


func _ready() -> void:
	$AnimatedSprite2D.play()



func _on_timer_timeout() -> void:
	$Timer/TextureProgressBar.value = 2



func _on_timer_2_timeout() -> void:
	$Timer/TextureProgressBar.value = 3


func _on_timer_3_timeout() -> void:
	$Timer/TextureProgressBar.value = 4



func _on_timer_4_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level3.tscn")
