extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_up"):
		scroll_changed.emit(event.factor);
	elif event.is_action_pressed("scroll_down"):
		scroll_changed.emit(-event.factor);

signal scroll_changed(scroll_delta: float)

func _on_scroll(value):
	print("scoll : ", value);
