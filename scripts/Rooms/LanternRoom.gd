class_name LanternRoom
extends Node2D

@onready var game_camera: Camera2D = $"../../GameCamera"


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_exterior_n_pressed() -> void:
	game_camera.global_position = $"../ExteriorNorth/ExteriorNorthAnchor".global_position

func _on_bedroom_pressed() -> void:
	game_camera.global_position = $"../Bedroom/BedroomAnchor".global_position
