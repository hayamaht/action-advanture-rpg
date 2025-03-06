extends PlayerState

var _attacking := false

func _enter() -> void:
	_attacking = true
	_player.apply_attack()

	await get_tree().create_timer(0.075).timeout
	if _attacking == true:
		pass
		#player.hurt_box.monitoring = true

func _exit() -> void:
	_attacking = false
	#player.hurt_box.monitoring = false
	#set_deferred(player.hurt_box.monitoring, false)

func _update(delta: float) -> void:
	_player.apply_decelerate(delta)

	if not _attacking:
		_player.hsm.dispatch("to_idle")
		#if _player.direction == Vector2.ZERO:
			#_player.hsm.dispatch("to_idle")
		#else:
			#_player.hsm.dispatch("to_move")

func end_attack(_data):
	_attacking = false
