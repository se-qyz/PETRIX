extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -700.0
var accept = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and accept == 0:
		accept = 1
		$Sprite2D.hide()
	
	if Input.is_action_just_pressed("ui_accept") and accept == 1:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if not is_on_floor() and accept == 1:
		velocity += get_gravity() * delta
	if accept == 1:
		velocity.x = move_toward(velocity.x, 100, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.
