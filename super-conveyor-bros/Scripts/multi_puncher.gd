extends Node3D

var break_time:float = 6.0
var on_break: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disable_and_hide_node($Puncher)
	disable_and_hide_node($Chopper)
	disable_and_hide_node($Heavy)
	$Break.stop()
	_on_puncher_break_over()
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	if on_break:
		break_time -= delta
		if break_time <= 0:
			break_time = 6.0
			$Break.frame = 0
			on_break = false
			_on_puncher_break_over()

func _handle_break() -> void:
	disable_and_hide_node($Puncher)
	disable_and_hide_node($Chopper)
	disable_and_hide_node($Heavy)
	$Break.play()
	on_break = true

func _on_puncher_break_over() -> void:
	var rand = RandomNumberGenerator.new().randi_range(0, 2)
	match rand:
		0:
			enable_and_show_node($Puncher)
			disable_and_hide_node($Chopper)
			disable_and_hide_node($Heavy)
		1:
			disable_and_hide_node($Puncher)
			enable_and_show_node($Chopper)
			disable_and_hide_node($Heavy)
		2:
			disable_and_hide_node($Puncher)
			disable_and_hide_node($Chopper)
			enable_and_show_node($Heavy)

func disable_and_hide_node(node:Node) -> void:
	node.process_mode = 4 # = Mode: Disabled
	node.hide()
	
func enable_and_show_node(node:Node) -> void:
	node.process_mode = 0 # = Mode: Inherit
	node.show()
	if node.has_method("set_random_bro_state"):
		node.set_random_bro_state(true)
