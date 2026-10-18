extends Node2D

@export var max_active := 5
@export var spawn_interval_min := 15.0
@export var spawn_interval_max := 30.0
@export var first_spawn_delay := 5.0

var spawn_timer := Timer.new()

func _ready() -> void:
	add_child(spawn_timer)
	spawn_timer.one_shot = true
	spawn_timer.timeout.connect(_try_spawn)
	spawn_timer.start(first_spawn_delay)

func _try_spawn() -> void:
	var all := get_tree().get_nodes_in_group("hallucination")
	var active := all.filter(func(h): return h.is_active)
	var inactive := all.filter(func(h): return not h.is_active)

	if active.size() < max_active and not inactive.is_empty():
		inactive.pick_random().spawn()

	spawn_timer.start(randf_range(spawn_interval_min, spawn_interval_max))
