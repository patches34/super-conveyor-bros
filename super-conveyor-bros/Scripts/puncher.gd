extends Node3D
var body_animator:AnimatedSprite3D
var vfx_animator:AnimatedSprite3D
var impact_area:Area3D
var speed:float = 1.0
var obj_below:Item = null
@export var min_damage:int = 1
@export var max_damage:int = 5
@export var damage_frames:Array[int]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_animator = $Body
	vfx_animator = $VFX
	impact_area = $Area3D
	body_animator.play()
	vfx_animator.play()
	speed = body_animator.speed_scale
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

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
	speed = new_speed
	vfx_animator.speed_scale = speed
	body_animator.speed_scale = speed
	

func set_vfx_active(state:bool) -> void:
	vfx_animator.visible = state
	


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is Item:
		obj_below = area


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area is Item && area == obj_below:
		obj_below = null
