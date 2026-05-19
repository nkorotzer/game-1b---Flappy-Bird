extends AnimatableBody2D

class_name Coin

var speed: int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.LEFT * speed * delta
	var col: KinematicCollision2D = move_and_collide(velocity)
	if col:
		SignalBus.coin_hit.emit()
		self.queue_free()
	
func reset() -> void:
	self.queue_free()
