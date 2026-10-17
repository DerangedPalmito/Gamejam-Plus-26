class_name Bedroom
extends Node2D
@onready var game_camera: Camera2D = $"../../GameCamera"
@onready var fundo: ColorRect = $OpenValveTask/Fundo

func _ready() -> void:
	fundo.hide()
	pass

func _process(delta: float) -> void:
	pass

func _on_open_valve_task_pressed() -> void:
	var task_popup = $OpenValveTask
	task_popup.visible = true
	task_popup.is_task_active = true
	fundo.show()
