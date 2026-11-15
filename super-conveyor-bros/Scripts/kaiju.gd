class_name Kaiju
extends Node3D
signal energy_change
signal attack
@export var body_animator:AnimatedSprite3D
@export var display_min_value:float = 0
@export var display_max_value:float = 100
@export var score_modifier:int = 1
@export var kaiju_vfx:SpriteFrames

enum AnimState {
	idle,
	charge,
	shoot,
}

var current_state:AnimState = AnimState.idle
var energy: float = 0
var max_energy: float = 100
var energy_percentage:float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VFX.sprite_frames = kaiju_vfx
	$VFX.frame = 0
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
		gain_energy(10)
	
func gain_energy(added_energy: float) -> void:
	energy += added_energy
	energy_percentage = energy / max_energy
	if energy_percentage >= 1:
		current_state = AnimState.charge
		energy = 0
		energy_percentage = 0
	var lerped_energy = lerp(display_min_value, display_max_value, energy_percentage)
	energy_change.emit(lerped_energy)

func _on_body_frame_changed() -> void:
	match current_state:
		AnimState.idle: 
			if body_animator.frame < 0 || body_animator.frame > 0:
				body_animator.frame = 0
				
		AnimState.charge:
			if body_animator.frame < 0 || body_animator.frame > 10:
				body_animator.frame = 0
				
			if body_animator.frame == 10:
				current_state = AnimState.shoot
				$VFX.frame = 0
				$VFX.play()
					
		AnimState.shoot:
			if body_animator.frame < 11 || body_animator.frame > 14:
				body_animator.frame = 11


func _on_vfx_frame_changed() -> void:
	if $VFX.frame == 8:
		current_state = AnimState.idle
		body_animator.frame = 0
		attack.emit(score_modifier)
