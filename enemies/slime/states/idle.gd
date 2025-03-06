extends EnemyState

var _time: float = 0.0

func _enter() -> void:
	_time = randf_range(_enemy.duration_min, _enemy.duration_max)
	_enemy.velocity = Vector2.ZERO
	_enemy.apply_animation("idle")

func _update(delta: float) -> void:
	_time -= delta

	if _time <= 0:
		dispatch("to_move")
