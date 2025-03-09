extends PlayerState

func _enter() -> void:
	_player.apply_animation(PlayerState.IDLE)

func _update(_delta: float) -> void:
	_player.change_dir()

	if _player.direction != Vector2.ZERO:
		dispatch(PlayerState.TO_WALK)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		dispatch(PlayerState.TO_ATTACK)

	if event.is_action_pressed("interact"):
		PlayerManager.interact_pressed.emit()
