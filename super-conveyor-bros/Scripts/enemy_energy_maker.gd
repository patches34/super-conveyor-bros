extends Node3D
var timer: float = 2
@export var enemy_kaiju:Kaiju
@export var min_time_between:float = 5.0
@export var max_time_between:float = 7.0
@export var chance_of_big:float = 0.1
@export var chance_of_mid:float = 0.3

var rng:RandomNumberGenerator


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()
	timer = rng.randf_range(min_time_between, max_time_between)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		timer = rng.randf_range(min_time_between, max_time_between)
		var chance = rng.randf_range(0, 1)
		if chance < chance_of_big:
			enemy_kaiju.consume_item(10)
		elif chance < chance_of_big + chance_of_mid:
			enemy_kaiju.consume_item(4)
		else:
			enemy_kaiju.consume_item(1)
	pass
