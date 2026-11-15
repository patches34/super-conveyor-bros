class_name Kaiju
extends Node3D

@export var body_animator:AnimatedSprite3D

enum AnimState {
	idle,
	charge,
	shoot,
}

var current_state:AnimState = AnimState.charge
var energy: float = 0
var max_energy: float = 100
var energy_percentage:float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_animator.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func consume_item(item_health_remaining:int) -> void:
	if item_health_remaining >= 1 && item_health_remaining <= 5:
		gain_energy(10)
	elif item_health_remaining >= 6 && item_health_remaining <= 20:
		gain_energy(4)
	elif item_health_remaining >= 21 && item_health_remaining <= 50:
		gain_energy(1)
	
func gain_energy(added_energy: float) -> void:
	energy += added_energy
	energy_percentage = energy / max_energy
	if energy_percentage >= 1:
		print("fire") #TODO: fire here
		energy = 0
		energy_percentage = 0


func _on_body_frame_changed() -> void:
	match current_state:
		AnimState.idle: 
			if body_animator.frame < 0 || body_animator.frame > 0:
				body_animator.frame = 0
				
		AnimState.charge:
			if body_animator.frame < 0 || body_animator.frame > 10:
				body_animator.frame = 0
				
			print(body_animator.frame)
			if body_animator.frame == 10:
				current_state = AnimState.shoot
					
		AnimState.shoot:
			if body_animator.frame < 11 || body_animator.frame > 14:
				body_animator.frame = 11
