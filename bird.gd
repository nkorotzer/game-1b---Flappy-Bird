extends CharacterBody2D

class_name Bird

const SPEED: int = 300
const JUMP_VELOCITY = -500.0
const STARTING_POS = 150
signal bird_collided

var screen_size: Vector2i

func _ready() -> void:
	screen_size = (get_viewport() as Window).size

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 2

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up") and not position.y < 0:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var is_col: bool = move_and_slide()
	if is_col:
		emit_signal("bird_collided")
	
func reset() -> void:
	position.x = STARTING_POS
	position.y = screen_size.y / 2.0
