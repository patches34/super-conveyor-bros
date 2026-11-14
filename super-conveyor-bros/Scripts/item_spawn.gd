extends Node3D

@export var item_prefab: PackedScene = preload("res://Prefabs/item.tscn")

@export var spawn_point: Vector3;

@export var scroll_signal:Scrol_Input

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spawn"):
		on_spawn()

func on_spawn():
	
	print("spawn")
	var instance:Item = item_prefab.instantiate()
	
	scroll_signal.scroll_changed.connect(instance._on_scroll)
	
	add_child(instance)
	
	
	
	instance.global_position = global_position + spawn_point
