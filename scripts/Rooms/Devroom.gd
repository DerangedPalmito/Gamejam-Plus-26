extends Node2D
@onready var game_camera: Camera2D = $GameCamera
@onready var screen_fade: ColorRect = $UI/ScreenFade
@onready var foot_steps: AudioStreamPlayer2D = $Audios/SFX/FootSteps
@onready var outside_sfx: AudioStreamPlayer2D = $Audios/SFX/OutsideSFX
@onready var inside_sfx: AudioStreamPlayer2D = $Audios/SFX/InsideSFX

@onready var rooms_map: Dictionary = {
	"Bedroom": {
		"position": $Rooms/Bedroom/BedroomAnchor.global_position,
		"connections": { "N": "LanternRoom" }
	},
	"LanternRoom": {
		"position": $Rooms/LanternRoom/LanternRoomAnchor.global_position,
		"connections": { "S": "Bedroom", "N": "ExteriorNorth" }
	},
	"ExteriorNorth": {
		"position": $Rooms/ExteriorNorth/ExteriorNorthAnchor.global_position,
		"connections": { "S": "LanternRoom", "O": "ExteriorWest", "L": "ExteriorEast" }
	},
	"ExteriorWest": {
		"position": $Rooms/ExteriorWest/ExteriorWestAnchor.global_position,
		"connections": { "L": "ExteriorNorth", "O": "ExteriorSouth" }
	},
	"ExteriorEast": {
		"position": $Rooms/ExteriorEast/ExteriorEastAnchor.global_position,
		"connections": { "O": "ExteriorNorth", "L": "ExteriorSouth" }
	},
	"ExteriorSouth": {
		"position": $Rooms/ExteriorSouth/ExteriorSouthAnchor.global_position,
		"connections": { "O": "ExteriorEast", "L": "ExteriorWest" }
	}
}
var current_room: String = "Bedroom"
var in_transaction: bool = false

func _ready() -> void:
	if(current_room.begins_with("Exterior")):
		outside_sfx.play()
	else:
		inside_sfx.play()
	game_camera.global_position = rooms_map[current_room]["position"]
	screen_fade.color.a = 0.0
	screen_fade.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		try_to_move("N")
	elif event.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		try_to_move("S")
	elif event.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		try_to_move("O")
	elif event.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		try_to_move("L")

func try_to_move(direction: String) -> void:
	if in_transaction:
		return
		
	var current_connections = rooms_map[current_room]["connections"]
	
	if current_connections.has(direction):
		var next_room = current_connections[direction]
		change_room(next_room)

func change_room(new_room: String) -> void:
	if new_room.begins_with("Exterior"):
		outside_sfx.play()
		inside_sfx.stop()
	else:
		inside_sfx.play()
		outside_sfx.stop()
	foot_steps.play()
	in_transaction = true
	screen_fade.mouse_filter = Control.MOUSE_FILTER_STOP

	var tween_out = create_tween()
	tween_out.tween_property(screen_fade, "color:a", 1.0, 0.3)
	await tween_out.finished

	game_camera.global_position = rooms_map[new_room]["position"]
	current_room = new_room

	var tween_in = create_tween()
	tween_in.tween_property(screen_fade, "color:a", 0.0, 0.3)
	await tween_in.finished

	screen_fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	in_transaction = false
	foot_steps.stop()
