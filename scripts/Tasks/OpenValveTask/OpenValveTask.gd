extends Control

signal task_finished

@export var grab_radius: float = 120.0
@export var turns_needed: float = 1.0  # quantas voltas completas para terminar

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

var is_dragging: bool = false
var is_task_active: bool = false
var total_rotation: float = 0.0  # em radianos
var last_angle: float = 0.0

func _ready() -> void:
	reset_task()
	visible = false

func reset_task() -> void:
	is_dragging = false
	total_rotation = 0.0
	texture_progress_bar.value = 0.0

func start_task() -> void:
	reset_task()
	is_task_active = true
	visible = true

func _get_center() -> Vector2:
	return texture_progress_bar.global_position + texture_progress_bar.size / 2.0

func _unhandled_input(event: InputEvent) -> void:
	if not visible or not is_task_active:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var center := _get_center()
			var mouse_pos := get_global_mouse_position()
			if mouse_pos.distance_to(center) < grab_radius:
				is_dragging = true
				last_angle = (mouse_pos - center).angle()
		else:
			is_dragging = false

	if is_dragging and event is InputEventMouseMotion:
		update_valve_rotation()

func update_valve_rotation() -> void:
	var angle := (get_global_mouse_position() - _get_center()).angle()
	var delta := angle_difference(last_angle, angle)
	last_angle = angle

	if delta <= 0.0:
		return

	total_rotation += delta

	var progress := clampf(total_rotation / (TAU * turns_needed) * 100.0, 0.0, 100.0)
	texture_progress_bar.value = progress

	if progress >= 99.0:
		finish_task()

func finish_task() -> void:
	is_task_active = false
	visible = false
	reset_task()
	task_finished.emit()
