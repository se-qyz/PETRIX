extends CharacterBody2D

class_name Player

@onready var healthBar = $HealthBar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

#health
var maxHealth = 100
var health = 100
var is_dead = 0
var was_attacked = 0
var damage_sound = 0
var immunity = 0

#knockback
var knockbackVelocity: Vector2
var knockbackForce = 500

func _ready():
	healthBar._set_health_bar(health, maxHealth)

func get_knockback(knockbackDirection, knockbackForce):
	knockbackVelocity = knockbackDirection * knockbackForce
	
	await get_tree().create_timer(0.1).timeout
	
	knockbackVelocity = Vector2.ZERO

func take_damage(damage:int):
	if immunity < 1:
		$"Damage Timer".start()
		$"Immunity Timer".start()
		$TakeDamageSound.play()
		was_attacked = 1
		immunity = immunity + 1
		health -= damage
		healthBar._change_health(-damage)
		var knockbackDirection = global_position.direction_to($".".global_position)
		knockbackDirection.y = 0
		knockbackDirection.x = -1
		get_knockback(knockbackDirection, knockbackForce)
	if health < 1:
		is_dead = is_dead + 1 
		respawn()


func take_heal(heal:int):
	health += heal
	healthBar._change_health(+heal)

#NEED add respawn cutscene
func respawn():
	if is_dead == 1:
		$"Death Timer".start()
		$DeathSound.play()
		$"../../AudioStreamPlayer2D".stop()

const SPEED = 300.0
const JUMP_VELOCITY = -490.0
var just_jumped = 0

func _physics_process(delta: float) -> void:
	if is_on_floor():
		just_jumped = 0
	
	if knockbackVelocity:
		velocity = knockbackVelocity
	
	if was_attacked == 1:
		$AnimatedSprite2D.play("damage")
	
	# Add animation
	elif velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "running"
	
	elif was_attacked == 0:
		animated_sprite_2d.animation = "idle"

	# Add the gravity.
	if not is_on_floor() and was_attacked == 0:
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and just_jumped < 2 and was_attacked == 0 and is_dead == 0:
		velocity.y = JUMP_VELOCITY
		just_jumped = just_jumped + 1
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and was_attacked == 0 and is_dead == 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0 and is_dead == 0:
		animated_sprite_2d.flip_h = true


func _on_spike_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		body.take_damage(30)


func _on_damage_timer_timeout() -> void:
	was_attacked = 0


func _on_crow_damage_finished() -> void:
	$TakeDamageSound.stop()


func _on_death_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_immunity_timer_timeout() -> void:
	immunity = 0
