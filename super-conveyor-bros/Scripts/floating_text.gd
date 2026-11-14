extends Node3D
var velocity:Vector3
var gravity:Vector3 = Vector3(0.0, -5, 0)
var damping:float = 0.99
var time:float
var fade_time:float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	begin_effect(5, Vector3(-1, 3, 0), 0.6)
	pass

func begin_effect(num: int, dir: Vector3, duration: float) -> void:
	$Label3D.text = str(num)
	velocity = dir
	time = duration
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity += gravity * delta
	velocity *= (damping ** delta)
	position += velocity * delta
	
	time -= delta
	if time <= fade_time:
		$Label3D.modulate.a = time / fade_time
		$Label3D.outline_modulate.a = time / fade_time
	
	if time <= 0:
		queue_free()
