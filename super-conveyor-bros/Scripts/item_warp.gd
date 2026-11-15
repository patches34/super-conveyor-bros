class_name ItemWarp
extends Node3D

@export var set_point:Vector3

signal item_warped(item:Item)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	#print(area.move_dir)
	
	#if (signf(area.move_dir) != signf(set_point.x)):
		#getting called twice? from both warps
	item_warped.emit(area)

func _on_item_warped(item: Item) -> void:
	item.global_position = global_position + set_point;
	
	item.move_dir *= -1
