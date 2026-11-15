extends Node3D
@export var kaiju:Kaiju

signal on_capture(item:Item)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	var health = area.get("health")
	
	kaiju.consume_item(health)
	
	area._on_capture()
	
	on_capture.emit(area)
