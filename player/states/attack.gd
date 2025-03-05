extends PlayerState

var _attacking := false

func _enter() -> void:
	_attacking = true
	_player.animation_player.animation_finished.connect(end_attack)
	_player.apply_animation("attack")
	_player.splash_animation_player.play("attack_" + _player.apply_dir())
	#player.audio.stream = attack_sound
	#player.audio.pitch_scale = randf_range(0.9, 1.1)
	#player.audio.play()

	await get_tree().create_timer(0.075).timeout
	if _attacking == true:
		pass
		#player.hurt_box.monitoring = true

func _exit() -> void:
	_player.animation_player.animation_finished.disconnect(end_attack)
	_attacking = false
	#player.hurt_box.monitoring = false
	#set_deferred(player.hurt_box.monitoring, false)

func _update(delta: float) -> void:
	_player.velocity -= _player.velocity * _player.decelerate_speed * delta
	#print("_update() attacking= ", attacking)
	#print("_update() _player.direction = ", _player.direction )
	if not _attacking:
		_player.hsm.dispatch("to_idle")
		#if _player.direction == Vector2.ZERO:
			#_player.hsm.dispatch("to_idle")
		#else:
			#_player.hsm.dispatch("to_move")

func end_attack(_data):
	_attacking = false
