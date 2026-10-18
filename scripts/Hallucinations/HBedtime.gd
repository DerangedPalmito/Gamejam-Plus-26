extends StaticBody2D

@export var time_to_die := 2.0
@export var respawn_time := 8.0
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer_till_death: Timer = $TimerTillDeath
@onready var respawn_timer: Timer = $RespawnTimer

func _ready() -> void:
	add_to_group("hallucination")
	timer_till_death.one_shot = true
	timer_till_death.wait_time = time_to_die
	timer_till_death.timeout.connect(_on_death)
	respawn_timer.one_shot = true
	respawn_timer.wait_time = respawn_time
	respawn_timer.timeout.connect(_on_respawn)

func lit() -> void:
	if visible and timer_till_death.is_stopped():
		timer_till_death.start()

func unlit() -> void:
	timer_till_death.stop()

func _on_death() -> void:
	hide()
	collision.set_deferred("disabled", true)
	respawn_timer.start()

func _on_respawn() -> void:
	show()
	collision.set_deferred("disabled", false)
