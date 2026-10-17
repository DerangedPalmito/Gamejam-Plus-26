class_name LanternRoom
extends Node2D
@onready var game_camera: Camera2D = $"../../GameCamera"
@onready var fundo_2: ColorRect = $CleaningGlassTask/Fundo2
@onready var fundo: ColorRect = $CleaningWindowTask/Fundo
@onready var cleaning_window_task: Control = $CleaningWindowTask
@onready var cleaning_glass_task: Control = $CleaningGlassTask

func _ready() -> void:
	fundo.hide()
	fundo_2.hide()
func _process(delta: float) -> void:
	pass

func _on_exterior_n_pressed() -> void:
	game_camera.global_position = $"../ExteriorNorth/ExteriorNorthAnchor".global_position

func _on_bedroom_pressed() -> void:
	game_camera.global_position = $"../Bedroom/BedroomAnchor".global_position

func _on_cleaning_window_task_1_pressed() -> void:	
	var task_popup = $CleaningWindowTask
	task_popup.visible = true
	task_popup.is_task_active = true
	fundo.show()

func _on_cleaning_glass_task_1_pressed() -> void:
	var task_popup = $CleaningGlassTask
	task_popup.visible = true
	task_popup.is_task_active = true
	fundo_2.show()
	
