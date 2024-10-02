extends RigidBody2D

@export var direction: float
@export var speed: float
@export var despawn_time: float

var _velocity := Vector2.RIGHT


func _ready() -> void:
	add_to_group("souls")
	_velocity = _velocity.rotated(direction) * speed
	
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = despawn_time
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(_on_timer_timeout)


func _physics_process(delta: float) -> void:
	move_and_collide(_velocity * delta)


func _on_timer_timeout() -> void:
	queue_free()
