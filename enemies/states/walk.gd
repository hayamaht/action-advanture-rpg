extends EnemyState

var _time: float = 0.0
var _dir: Vector2

func _enter() -> void:
	_time = randi_range(_enemy.cycle_min, _enemy.cycle_max) * _enemy.animation_duration
	_enemy.apply_direction()
	_enemy.apply_animation("walk")

func _update(delta: float) -> void:
	_enemy.apply_movement(delta)

	_time -= delta

	if _time <= 0:
		dispatch("to_idle")
