extends GoblinState

var _time: float = 4.0

func _enter() -> void:
	#_time = _enemy.get_rand_cycle()
	_enemy.apply_rand_dir()
	_enemy.apply_animation(EnemyState.WALK)

func _update(delta: float) -> void:
	_enemy.apply_movement(delta)

	_time -= delta

	if _time <= 0:
		dispatch(EnemyState.TO_IDLE)

#func _on_hit_box_damaged(_hurt_box: HurtBox) -> void:
	#dispatch(EnemyState.TO_STUN)
