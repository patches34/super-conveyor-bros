extends Node
var velocity:Vector2
var gravity:Vector2 = Vector2(0.0, -9.91)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func begin_effect(num: int, dir: Vector2) -> void:
	$Label3D.text = str(num)
	velocity = dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity
