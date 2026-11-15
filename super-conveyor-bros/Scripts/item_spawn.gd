extends Node3D

@export var item_prefab: PackedScene = preload("res://Prefabs/item.tscn")

@export var spawn_point: Vector3;

@export var scroll_signal:Scrol_Input

@export var belt_index: int = 0
@export var level_man:LevelManager

@export var spawn_time: float = 4.0
var timer:float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	
	if (timer <= 0):
		on_spawn()
		
		timer = spawn_time

func on_spawn():
	var instance:Item = item_prefab.instantiate()
	
	scroll_signal.scroll_changed.connect(instance._on_scroll)
	
	instance.active_index = belt_index
	instance.belt_man = level_man
	
	add_child(instance)
	
	instance.global_position = global_position + spawn_point
	
