extends GoblinState

var _time: float = 0.0
var _dir: Vector2 = Vector2.ZERO
var _can_see_player := false

func _enter() -> void:
	_time = _enemy.state_aggro_duration
	_enemy.change_dir(_dir)
	_enemy.apply_animation(CHASE)
	if _enemy.attack_area:
		_enemy.attack_area.monitoring = true

func _exit() -> void:
	if _enemy.attack_area:
		_enemy.attack_area.monitoring = false
	_can_see_player = false

func _update(delta: float) -> void:
	var new_dir: Vector2 = _enemy.global_position.direction_to(
		PlayerManager.player.global_position
	)
	_dir = lerp(_dir, new_dir, _enemy.ture_rate)
	_enemy.change_dir(_dir)
	_enemy.velocity = _dir * _enemy.chase_speed
	#_enemy.apply_animation(CHASE)

	if _can_see_player == false:
		_time -= delta
		if _time <= 0:
			dispatch( TO_IDLE )
	else:
		_time = _enemy.state_aggro_duration

func _on_player_entered() -> void:
	_can_see_player = true
	dispatch(TO_CHASE)

func _on_player_exited() -> void:
	_can_see_player = false
	dispatch(TO_WALK)

func _on_hit_box_damaged(hurt_box: HurtBox) -> void:
	dispatch(TO_STUN)
