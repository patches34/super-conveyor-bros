extends Control

@export var enemy_bar:TextureProgressBar
@export var hero_bar:TextureProgressBar

@export var buckets: Array[TextureRect]

@export var current_index:int = 2

var game_win = preload("res://Scenes/game_win.tscn")
var game_lost = preload("res://Scenes/game_lost.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_score(value:int) -> void:
	buckets[current_index].visible = false;
	
	current_index += value
	
	buckets[current_index].visible = true;
	
	if(current_index < 0):
		#print("Player Lost")
		get_tree().change_scene_to_packed(game_lost)
	elif current_index >= 5:
		#print("Player Won")
		get_tree().change_scene_to_packed(game_win)


func  _on_hero_meter_change(value:float) -> void:
	hero_bar.value = value;

func _on_enemy_meter_change(value:float) -> void:
	enemy_bar.value = value;
