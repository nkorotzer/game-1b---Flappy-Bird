extends Node

var screen_size: Vector2i
var pipe_scn: PackedScene = preload("res://pipe.tscn")
var coin_scn: PackedScene = preload("res://coin.tscn")
var score: int
var pipe_gap: int = 125

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	($Score as TextEdit).text = "0"
	screen_size = (get_viewport() as Window).size
	SignalBus.coin_hit.connect(_on_coin_hit)


func _on_pipe_spawner_timeout() -> void:
#	spawn bottom pipe
	var pipe: Pipe = pipe_scn.instantiate()
	$Pipes.add_child(pipe)
	
	var random_height := randi_range(pipe_gap + 5, int(screen_size.y) - pipe_gap + 25)
	pipe.position.x = screen_size.x
	pipe.position.y = random_height

#	spawn top pipe
	var pipe_top: Pipe = pipe_scn.instantiate()
	$Pipes.add_child(pipe_top)
	
	pipe_top.position.x = pipe.position.x + 15
	pipe_top.rotation = PI
	pipe_top.position.y = pipe.position.y - pipe_gap
	
#	spawn coin
	var coin: Coin = coin_scn.instantiate()
	$Coins.add_child(coin)
	coin.position = pipe.position
	coin.position.y -= pipe_gap

func _on_bird_bird_collided() -> void:
	score = 0
	($Score as TextEdit).text = "0"
	($Bird as Bird).reset() 
	for node in $Pipes.get_children():
		if node is Pipe:
			(node as Pipe).reset()
	for node in $Coins.get_children():
		if node is Coin:
			(node as Coin).reset()
		
func _on_coin_hit() -> void:
	score += 1
	($Score as TextEdit).text = str(score)
