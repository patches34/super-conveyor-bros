extends Node
var health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	reduce_health(1)

func reduce_health(delta: int) -> void:
	health -= delta
	$Label3D.text = str(health)
