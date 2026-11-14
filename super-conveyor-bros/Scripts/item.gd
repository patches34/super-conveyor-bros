extends Node3D
var health: int
var floating_text_prefab = preload("res://Prefabs/floating_text.tscn")
var timer: float = 0.2

@export var move_speed: float = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#timer -= delta
	#position.x += delta * 0.5
	#var rng = RandomNumberGenerator.new()
	#if timer <= 0:
		#timer = 0.2
		#reduce_health(rng.randi_range(1, 5))
	pass


func reduce_health(delta: int) -> void:
	health -= delta
	$Label3D.text = str(health)
	
	var floating = floating_text_prefab.instantiate()
	get_tree().root.add_child(floating);
	floating.begin(delta)
	floating.global_position = $Label3D.global_position
	floating.global_position.y += 0.35
	
	if health < 0:
		queue_free()

func _on_scroll(value):
	print(value * move_speed)
	position += Vector3(value * move_speed, 0, 0);
