extends Control

signal task_finished(heal_amount: float)
@export var grab_radius: float = 120.0
@export var turns_needed: float = 1.0
@export var heal_amount := 10.0

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

var is_dragging: bool = false
var is_task_active: bool = false
var total_rotation: float = 0.0
var last_angle: float = 0.0

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	texture_progress_bar.mouse_filter = Control.MOUSE_FILTER_IGNORE
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
	print("pos: ", texture_progress_bar.global_position,
	" | size: ", texture_progress_bar.size,
	" | scale: ", texture_progress_bar.scale,
	" | pai: ", texture_progress_bar.get_parent().get_class(),
	" | canvas layer: ", texture_progress_bar.get_canvas_layer_node())

func _get_center() -> Vector2:
	return texture_progress_bar.get_global_transform() * (texture_progress_bar.size / 2.0)

func _unhandled_input(event: InputEvent) -> void:
	if not visible or not is_task_active:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var center := _get_center()
			var mouse_pos := get_global_mouse_position()
			print("centro: ", center, " | mouse: ", mouse_pos, " | dist: ", mouse_pos.distance_to(center))
			print("pos: ", texture_progress_bar.global_position,
		" | size: ", texture_progress_bar.size,
		" | scale: ", texture_progress_bar.scale,
		" | pai: ", texture_progress_bar.get_parent().get_class(),
		" | canvas layer: ", texture_progress_bar.get_canvas_layer_node())
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
	task_finished.emit(heal_amount)
