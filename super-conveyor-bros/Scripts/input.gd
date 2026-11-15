class_name Scrol_Input
extends Node

@export var scroll_speed: float = 1

@export var belt_texture:StandardMaterial3D
@export var bard_texture:StandardMaterial3D

var next_coord:Vector3

@export var lerp_speed = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	belt_texture.uv1_offset = belt_texture.uv1_offset.lerp(next_coord, lerp_speed);
	bard_texture.uv1_offset = bard_texture.uv1_offset.lerp(next_coord, lerp_speed);

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_up"):
		scroll_changed.emit(event.factor);
	elif event.is_action_pressed("scroll_down"):
		scroll_changed.emit(-(event.factor));

signal scroll_changed(scroll_delta: float)


func _on_scroll(value):
	next_coord.x += value * scroll_speed;
	
	print(next_coord);
	
