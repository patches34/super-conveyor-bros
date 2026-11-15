extends Node3D
signal break_over

var body_animator:AnimatedSprite3D
var vfx_animator:AnimatedSprite3D
var break_animator:AnimatedSprite3D
var impact_area:Area3D
var obj_below:Array[Item] = []
@export var min_damage:int = 1
@export var max_damage:int = 5
@export var damage_frames:Array[int]
@export var bro_state:Enums.BroStates

@export var min_state_time:float = 3.0
@export var max_state_time:float = 5.0

var sfx:AudioStreamPlayer

var state_tween
var timer:float = 1
var rng:RandomNumberGenerator



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_animator = $Body
	vfx_animator = $VFX
	impact_area = $Area3D
	break_animator = $Break
	sfx = $AudioStreamPlayer
	body_animator.play()
	vfx_animator.play()
	break_animator.visible = false
	set_random_bro_state()
	rng = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if timer < 0:
		timer = rng.randf_range(min_state_time, max_state_time)
		set_random_bro_state()

func _on_body_frame_changed() -> void:
	if(obj_below.size() > 0 && 
			damage_frames.find(body_animator.frame) != -1 &&
			bro_state != Enums.BroStates.away):
		for obj in obj_below:
			obj.reduce_health_range(min_damage, max_damage)
		sfx.play()
	
	vfx_animator.visible = obj_below.size() != 0
	vfx_animator.frame = body_animator.frame
	if vfx_animator.frame < 3:
		vfx_animator.position.x = -0.3
	else:
		vfx_animator.position.x = 0

func modify_speed(new_speed: float) -> void:
	if new_speed == 0:
		handle_going_away()
		return
	
	if state_tween:
		state_tween.kill()
	state_tween = get_tree().create_tween()
	state_tween.tween_property($VFX, "speed_scale", new_speed, 0.5)
	state_tween.tween_property($Body, "speed_scale", new_speed, 0.5)

func set_vfx_active(state:bool) -> void:
	vfx_animator.visible = state

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is Item:
		obj_below.append(area)

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area is Item:
		print("Before:" + str(obj_below.size()))
		obj_below = obj_below.filter(func(x): return x != area)
		print("After:" + str(obj_below.size()))

func set_random_bro_state() -> void:
	var next_state = (Enums.BroStates.values()
		.filter(func(s): return s != bro_state).pick_random())
	
	if bro_state == Enums.BroStates.away && next_state != Enums.BroStates.away:
		break_animator.visible = false
		break_animator.frame = 0
		body_animator.frame = 0
		vfx_animator.frame = 0
		body_animator.visible = true
		break_animator.stop()
		body_animator.play()
		break_over.emit()
		
	bro_state = next_state
	
	match bro_state:
		Enums.BroStates.away:
			modify_speed(0)
		Enums.BroStates.normal:
			modify_speed(1)
		Enums.BroStates.slow:
			modify_speed(0.75)
		Enums.BroStates.fast:
			modify_speed(2)

func handle_going_away() -> void:
	vfx_animator.visible = false
	vfx_animator.stop()
	body_animator.visible = false
	body_animator.stop()
	break_animator.visible = true
	break_animator.play()
