extends PointLight2D

@export var lantern_button: TextureButton

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	

func _on_texture_button_toggled(toggled_on: bool) -> void:
	enabled = true
	await get_tree().create_timer(4.0).timeout
	enabled = false
