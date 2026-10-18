extends Node2D

var hour_rotation_degrees:int = 18 * 60
@onready var minute_clock: Timer = $Timer
@onready var minute_hand: Node2D = $minute_hand
@onready var hour_hand: Node2D = $hour_hand

@export var time_scale: int = 1

func _ready() -> void:
	_update_clock_hands()

	minute_clock.timeout.connect(_on_timer_timeout)
	minute_clock.start()

func _on_timer_timeout() -> void:
	hour_rotation_degrees += time_scale
	
	if hour_rotation_degrees >= 2160:
		hour_rotation_degrees = 2160
		minute_clock.stop()
		#mudar cena pra a derrota
	
	_update_clock_hands()

func _update_clock_hands() -> void:
	var hour_rotation = hour_rotation_degrees * 0.5
	hour_hand.rotation = deg_to_rad(hour_rotation + 90)
	var minute_rotation_degrees: int = hour_rotation_degrees * 6
	minute_hand.rotation = deg_to_rad(minute_rotation_degrees)
