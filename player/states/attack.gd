extends PlayerState

var _attacking := false

func _enter() -> void:
	_attacking = true
	_player.apply_attack()

	await get_tree().create_timer(0.075).timeout
	if _attacking:
		_player.apply_hurt_box(true)

func _exit() -> void:
	_attacking = false
	_player.apply_hurt_box(false)
	#set_deferred(_player.hurt_box.monitoring, false)

func _update(delta: float) -> void:
	_player.apply_decelerate(delta)

	if not _attacking:
		dispatch(PlayerState.TO_IDLE)

func end_attack(_data):
	_attacking = false
