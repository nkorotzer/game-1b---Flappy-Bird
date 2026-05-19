extends AnimatableBody2D

class_name Pipe

var speed: int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.LEFT * speed * delta
	move_and_collide(velocity)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()

func reset() -> void:
	self.queue_free()
