extends Control

@export var enemy_bar:TextureProgressBar
@export var hero_bar:TextureProgressBar

@export var buckets: Array[TextureRect]

@export var current_index:int = 2

var game_win: String = "game_win"
var game_lost: String = "game_lost"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score(0)
	SceneManager.validate_scene(game_win)
	SceneManager.validate_scene(game_lost)
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
		SceneManager.no_effect_change_scene(game_lost)
	elif current_index >= 5:
		#print("Player Won")
		SceneManager.no_effect_change_scene(game_win)


func  _on_hero_meter_change(value:float) -> void:
	hero_bar.value = value;

func _on_enemy_meter_change(value:float) -> void:
	enemy_bar.value = value;
