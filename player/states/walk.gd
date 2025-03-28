extends PlayerState

func _enter() -> void:
	_player.apply_animation(PlayerState.WALK)


func _update(delta: float) -> void:
	_player.apply_movement(delta)

	if _player.change_dir():
		_player.apply_animation("walk")

	if _player.direction == Vector2.ZERO:
		dispatch(PlayerState.TO_IDLE)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		dispatch(PlayerState.TO_ATTACK)

	if event.is_action_pressed("interact"):
		PlayerManager.interact_pressed.emit()
