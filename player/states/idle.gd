extends PlayerState

func _enter() -> void:
	_player.apply_animation("idle")

func _update(_delta: float) -> void:
	_player.change_dir()

	if _player.direction != Vector2.ZERO:
		_player.hsm.dispatch("to_move")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		_player.hsm.	dispatch("to_attack")
