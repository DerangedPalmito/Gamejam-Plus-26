extends Node2D
@onready var game_camera: Camera2D = $"../../GameCamera"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_exterior_north_pressed() -> void:
	game_camera.global_position = $"../ExteriorNorth/ExteriorNorthAnchor".global_position

func _on_exterior_west_pressed() -> void:
	game_camera.global_position = $ExteriorWestAnchor.global_position

func _on_exterior_east_pressed() -> void:
	game_camera.global_position = $"../ExteriorEast/ExteriorEastAnchor".global_position
