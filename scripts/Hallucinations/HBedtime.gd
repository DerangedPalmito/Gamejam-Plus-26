extends StaticBody2D

signal damage_dealt(amount: float)

@export var time_to_die := 2.0
@export var damage_interval := 1.0
@export var damage_amount := 1.0

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer_till_death: Timer = $TimerTillDeath

var is_active := false
var damage_cooldown := 0.0

func _ready() -> void:
	add_to_group("hallucination")
	timer_till_death.one_shot = true
	timer_till_death.wait_time = time_to_die
	timer_till_death.timeout.connect(_on_death)
	_deactivate()

func _process(delta: float) -> void:
	if not is_active:
		return
	damage_cooldown += delta
	if damage_cooldown >= damage_interval:
		damage_cooldown = 0.0
		damage_dealt.emit(damage_amount)

func spawn() -> void:
	is_active = true
	damage_cooldown = 0.0
	timer_till_death.stop()
	timer_till_death.paused = false
	show()
	collision.set_deferred("disabled", false)

func lit() -> void:
	if not is_active:
		return
	if timer_till_death.is_stopped():
		timer_till_death.start()
	else:
		timer_till_death.paused = false

func unlit() -> void:
	timer_till_death.paused = true

func _on_death() -> void:
	timer_till_death.paused = false
	_deactivate()

func _deactivate() -> void:
	is_active = false
	hide()
	collision.set_deferred("disabled", true)
