extends Node2D

const SOUL = preload("res://Objects/Soul/soul.tscn")

@export var spawn_timer_range := Vector2(0.2, 0.5)

var spawn_timer := Timer.new()

@onready var lighthouse: Node2D = $Lighthouse


func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)
	_restart_spawn_timer(randf_range(spawn_timer_range[0], spawn_timer_range[1]))


func _spawn_soul() -> void:
	var soul := SOUL.instantiate()
	self.add_child.call_deferred(soul)
	soul.global_position = Vector2.RIGHT.rotated(randf_range(0.0, 2*PI)) * randf_range(3*360.0, 4*360.0) + Vector2(360.0, 360.0)
	soul.direction = soul.global_position.angle_to_point(lighthouse.global_position + Vector2.RIGHT.rotated(randf_range(0.0, 2*PI)) * randf_range(0.0, 1*360.0))
	soul.speed = randf_range (100.0, 300.0)
	soul.despawn_time = randf_range(20.0, 30.0)


func _restart_spawn_timer(wait_time:float) -> void:
	spawn_timer.start(wait_time)


func _on_spawn_timer_timeout() -> void:
	_spawn_soul()
	_restart_spawn_timer(randf_range(spawn_timer_range[0], spawn_timer_range[1]))
