extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal player_died
const SPEED = 50.0
var direction = -1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction * SPEED * delta



func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		body.take_damage(34)
 

func _on_player_died() -> void:
	pass


func _on_timeout():
	direction *= -1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
