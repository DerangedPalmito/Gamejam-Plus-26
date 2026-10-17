extends Control

signal task_finished

@onready var texture_progress: TextureProgressBar = $TextureProgressBar

var is_dragging: bool = false
var is_task_active: bool = false

func _ready() -> void:
	visible = false
	texture_progress.value = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var center = texture_progress.global_position + (texture_progress.size / 2.0)
			if get_global_mouse_position().distance_to(center) < 120.0: # Ajuste o raio conforme o tamanho
				is_dragging = true
		else:
			is_dragging = false

	if is_dragging and event is InputEventMouseMotion:
		calculate_valve_angle()

func calculate_valve_angle() -> void:
	var center = texture_progress.global_position + (texture_progress.size / 2.0)
	var mouse_pos = get_global_mouse_position()
	
	var angle_rad = (mouse_pos - center).angle()
	
	var angle_deg = rad_to_deg(angle_rad) + 180.0 
	
	var progress_value = (angle_deg / 360.0) * 100.0
	texture_progress.value = progress_value
	
	if texture_progress.value >= 99.0:
		finish_task()

func finish_task() -> void:
	is_dragging = false
	visible = false
	print("Válvula totalmente girada!")
	task_finished.emit()
