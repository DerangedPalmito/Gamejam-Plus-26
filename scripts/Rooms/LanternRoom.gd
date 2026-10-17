class_name LanternRoom
extends Node2D
@onready var game_camera: Camera2D = $"../../GameCamera"
@onready var fundo: ColorRect = $CleaningWindowTask/Fundo
@onready var bedroom: Button = $Bedroom
@onready var cleaning_window_task: Control = $CleaningWindowTask

func _ready() -> void:
	fundo.hide()
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
	bedroom.disabled
	
