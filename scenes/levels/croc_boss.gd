extends Area2D
@onready var healthBar = $HealthBar/TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	



func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		body.respawn()
		healthBar._change_health(0)
