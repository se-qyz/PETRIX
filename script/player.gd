extends CharacterBody2D

class_name Player

@onready var healthBar = $HealthBar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

#health
var maxHealth = 100
var health = 100

func _ready():
	healthBar._set_health_bar(health, maxHealth)

func take_damage(damage:int):
	health -= damage
	if health < 1: 
		respawn()
	healthBar._change_health(-damage)
	
	animated_sprite_2d.animation = "damage"

func take_heal(heal:int):
	health += heal
	healthBar._change_health(+heal)

#NEED add respawn cutscene
func respawn():
	get_tree().reload_current_scene()

const SPEED = 300.0
const JUMP_VELOCITY = -490.0
var just_jumped = 0

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		just_jumped = 0
	
	# Add animation
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "idle"
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and just_jumped < 2:
		velocity.y = JUMP_VELOCITY
		just_jumped = just_jumped + 1
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true


func _on_spike_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		body.take_damage(30)
