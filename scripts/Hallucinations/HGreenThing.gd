extends StaticBody2D
@export var time_to_die := 2.0
@export var respawn_time := 8.0
@export var damage_interval := 1.0
@export var damage_amount := 1.0
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer_till_death: Timer = $TimerTillDeath
@onready var respawn_timer: Timer = $RespawnTimer
@onready var light_house_life_bar: ProgressBar = $"../../UI/CanvasLayer/LightHouseLifeBar"
signal damage_dealt(amount: float)

var is_active := true
var damage_cooldown := 0.0

func _ready() -> void:
	add_to_group("hallucination")
	timer_till_death.one_shot = true
	timer_till_death.wait_time = time_to_die
	timer_till_death.timeout.connect(_on_death)
	respawn_timer.one_shot = true
	respawn_timer.wait_time = respawn_time
	respawn_timer.timeout.connect(_on_respawn)

func _process(delta: float) -> void:
	if not is_active:
		return
	damage_cooldown += delta
	if damage_cooldown >= damage_interval:
		damage_cooldown = 0.0
		do_damage()

func do_damage() -> void:
	if is_active:
		damage_dealt.emit(damage_amount)

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
	is_active = false
	hide()
	collision.set_deferred("disabled", true)
	respawn_timer.start()

func _on_respawn() -> void:
	is_active = true
	show()
	collision.set_deferred("disabled", false)
