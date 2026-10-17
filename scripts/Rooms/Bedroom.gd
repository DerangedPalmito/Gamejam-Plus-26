class_name Bedroom
extends Node2D
@onready var screen_fade: ColorRect = $"../../UI/ScreenFade"
@onready var game_camera: Camera2D = $"../../GameCamera"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	#game_camera.global_position = Vector2(1280, 720)
	game_camera.global_position = $"../LanternRoom/LanternRoomAnchor".global_position
