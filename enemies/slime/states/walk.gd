extends EnemyState

var _time: float = 0.0

func _enter() -> void:
	_time = _enemy.get_rand_time()
	_enemy.apply_direction()
	_enemy.apply_animation("walk")

func _update(delta: float) -> void:
	_enemy.apply_movement(delta)

	_time -= delta

	if _time <= 0:
		dispatch("to_idle")

func _on_hit_box_damaged(_hurt_box: HurtBox) -> void:
	dispatch("to_stun")
