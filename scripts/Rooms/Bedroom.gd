class_name Bedroom
extends Node2D
@onready var game_camera: Camera2D = $"../../GameCamera"
@onready var fundo: ColorRect = $OpenValveTask/Fundo

func _ready() -> void:
	fundo.hide()

func _process(delta: float) -> void:
	pass

func _on_open_valve_task_button_pressed() -> void:
	var task_popup = $OpenValveTask
	task_popup.visible = true
	task_popup.is_task_active = true
	fundo.show()

func _on_lantern_room_pressed() -> void:
	game_camera.global_position = $"../LanternRoom/LanternRoomAnchor".global_position
