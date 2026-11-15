extends Node

var game_scene = preload("res://Scenes/game_title.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	game_scene = load("res://Scenes/game_title.tscn")
	
	get_tree().change_scene_to_packed(game_scene)
