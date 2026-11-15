extends Node3D
var body_animator:AnimatedSprite3D
var vfx_animator:AnimatedSprite3D
var impact_area:Area3D
var obj_below:Item = null
@export var min_damage:int = 1
@export var max_damage:int = 5
@export var damage_frames:Array[int]
@export var bro_state:Enums.BroStates

@export var min_state_time:float = 3.0
@export var max_state_time:float = 5.0
var state_tween
var timer:float = 1
var rng:RandomNumberGenerator


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_animator = $Body
	vfx_animator = $VFX
	impact_area = $Area3D
	body_animator.play()
	vfx_animator.play()
	set_random_bro_state()
	rng = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if timer < 0:
		timer = rng.randf_range(min_state_time, max_state_time)
		set_random_bro_state()

func _on_body_frame_changed() -> void:
	if(obj_below != null && 
			damage_frames.find(body_animator.frame) != -1):
		obj_below.reduce_health_range(min_damage, max_damage)
	
	vfx_animator.visible = obj_below != null
	vfx_animator.frame = body_animator.frame
	if vfx_animator.frame < 3:
		vfx_animator.position.x = -0.3
	else:
		vfx_animator.position.x = 0

func modify_speed(new_speed: float) -> void:
	if state_tween:
		state_tween.kill()
	state_tween = get_tree().create_tween()
	state_tween.tween_property($VFX, "speed_scale", new_speed, 0.5)
	state_tween.tween_property($Body, "speed_scale", new_speed, 0.5)

func set_vfx_active(state:bool) -> void:
	vfx_animator.visible = state

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is Item:
		obj_below = area

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area is Item && area == obj_below:
		obj_below = null

func set_random_bro_state() -> void:
	bro_state = (Enums.BroStates.values()
		.filter(func(s): return s != bro_state).pick_random())
	#print(Enums.BroStates.keys()[bro_state])
	match bro_state:
		Enums.BroStates.away:
			modify_speed(0)
		Enums.BroStates.normal:
			modify_speed(1)
		Enums.BroStates.slow:
			modify_speed(0.75)
		Enums.BroStates.fast:
			modify_speed(2)
