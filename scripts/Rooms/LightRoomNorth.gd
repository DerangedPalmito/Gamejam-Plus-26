extends Node2D
@onready var game_camera: Camera2D = $"../../GameCamera"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_lantern_room_pressed() -> void:
	game_camera.global_position = $"../LanternRoom/LanternRoomAnchor".global_position
