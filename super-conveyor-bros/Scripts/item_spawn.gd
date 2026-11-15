extends Node3D

var item_prefab: PackedScene = preload("res://Prefabs/item.tscn")

@export var max_spawn: int = 5
@export var spawns = []

@export var spawn_time: float = 4.0
var timer:float = 0

@export var spawn_node: Node3D;

@export var scroll_signal:Scrol_Input

var touching_bodies: Array[Area3D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawns = spawns.filter(func (item): return is_instance_valid(item))
	
	timer -= delta
	
	if (timer <= 0):
		on_spawn()
		
		timer = spawn_time

func on_spawn():
	if (spawns.size() < max_spawn) && (touching_bodies.size() == 0):
		var instance:Item = item_prefab.instantiate()
		
		scroll_signal.scroll_changed.connect(instance._on_scroll)
		
		add_child(instance)
		
		instance.global_position = global_position + spawn_node.position
		
		spawns.append(instance)


func _on_area_entered(area: Area3D) -> void:
	touching_bodies.append(area)


func _on_area_exited(area: Area3D) -> void:
	touching_bodies.erase(area)
