class_name Item
extends Area3D
@export var health: int = 100
var floating_text_prefab = preload("res://Prefabs/floating_text.tscn")
var timer: float = 0.2

var move_dir:int = 1;

@export var move_speed: float = 0.054

var touching_bodies: Array[Area3D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#timer -= delta
	#position.x += delta * 0.5
	#var rng = RandomNumberGenerator.new()
	#if timer <= 0:
		#timer = 0.2
		#reduce_health(rng.randi_range(1, 5))
	pass

func reduce_health_range(min: int, max: int) -> void:
	var rng = RandomNumberGenerator.new()
	reduce_health(rng.randi_range(min, max))

func reduce_health(delta: int) -> void:
	health -= delta
	$Label3D.text = str(health)
	
	var floating = floating_text_prefab.instantiate()
	get_tree().root.add_child(floating);
	floating.begin(delta)
	floating.global_position = $Label3D.global_position
	floating.global_position.y += 0.35
	
	if health <= 0:
		queue_free()

func _on_scroll(value):
	#print(value * move_speed)
	var delta:Vector3 = Vector3(value * move_speed * move_dir, 0, 0);
	
	if (!left_check() || delta.x > 0):
		position += delta;

func _on_capture():
	#print("been captured")
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	touching_bodies.append(area)


func _on_area_exited(area: Area3D) -> void:
	touching_bodies.erase(area)

func  left_check() -> bool:
	if touching_bodies.size() > 0:
		for body in touching_bodies:
			if body.global_position.x < global_position.x:
				if body is Item:
					return body.left_check()
				else:
					return true
	
	return false
