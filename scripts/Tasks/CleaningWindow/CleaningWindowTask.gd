extends Control

signal task_finished(heal_amount: float)

var current_progress: float = 0.0
var is_task_active: bool = false
var is_cleaning: bool = false
@export var cleaning_speed: float = 1.5
@export var heal_amount := 10.0

@onready var dirty_overlay: TextureRect = $DirtyOverlay
@onready var progress_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	visible = false
	dirty_overlay.modulate.a = 1.0
	if progress_bar:
		progress_bar.value = 0.0

func reset_task() -> void:
	current_progress = 0.0
	is_cleaning = false
	dirty_overlay.modulate.a = 1.0
	if progress_bar:
		progress_bar.value = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if not visible or not is_task_active:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_cleaning = event.pressed

	if is_cleaning and event is InputEventMouseMotion:
		add_progress(event.relative.length() * cleaning_speed * 0.05)

func add_progress(amount: float) -> void:
	if current_progress >= 100.0:
		return

	current_progress += amount
	current_progress = clamp(current_progress, 0.0, 100.0)

	if progress_bar:
		progress_bar.value = current_progress
	
	dirty_overlay.modulate.a = 1.0 - (current_progress / 100.0)

	if current_progress >= 100.0:
		finish_task()

func start_task() -> void:
	current_progress = 0.0
	is_cleaning = false
	is_task_active = true

	dirty_overlay.modulate.a = 1.0
	if progress_bar:
		progress_bar.value = 0.0
	visible = true

func finish_task() -> void:
	is_task_active = false
	current_progress = 0.0
	visible = false
	reset_task()
	is_cleaning = false
	task_finished.emit(heal_amount)
