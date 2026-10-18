extends PointLight2D

@onready var area: Area2D = $Area2D
var lit := false

func _ready() -> void:
	enabled = false
	area.monitoring = false

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	if not lit:
		return
	var inside := area.get_overlapping_bodies()
	for h in get_tree().get_nodes_in_group("hallucination"):
		if h in inside:
			h.lit()
		else:
			h.unlit()

func _on_texture_button_toggled(toggled_on: bool) -> void:
	if lit:
		return
	lit = true
	enabled = true
	area.monitoring = true
	await get_tree().create_timer(4.0).timeout
	enabled = false
	# avisa quem ainda estava na luz antes de desligar
	for body in area.get_overlapping_bodies():
		if body.is_in_group("hallucination"):
			body.unlit()
	area.set_deferred("monitoring", false)
	lit = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entrou: ", body.name)
	if body.is_in_group("hallucination"):
		body.lit()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("hallucination"):
		body.unlit()
