extends PlayerState

func _enter() -> void:
	_player.apply_animation("walk")


func _update(delta: float) -> void:
	_player.apply_movement(delta)

	if _player.change_dir():
		_player.apply_animation("walk")

	if _player.direction == Vector2.ZERO:
		_player.hsm.dispatch("to_idle")
