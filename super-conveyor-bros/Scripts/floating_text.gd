extends Node3D
var velocity:Vector3
var gravity:Vector3 = Vector3(0.0, -5, 0)
var damping:float = 0.99
var time:float
var fade_time:float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _begin_effect(num: int, dir: Vector3, duration: float) -> void:
	$Label3D.text = str(num)
	velocity = dir
	time = duration

func begin(num: int) -> void:
	var rng = RandomNumberGenerator.new()
	var rand_invert = 1
	if rng.randf_range(0, 1) < 0.5:
		rand_invert = -1
		
	position.x += 1.3 * rand_invert
	
	_begin_effect(num, 
		Vector3(rng.randf_range(1,2) * rand_invert, 
		rng.randf_range(3, 3.5), 0), 
		0.6)

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
