extends PlayerState


@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed := 5.0

var attacking := false

func _enter() -> void:
	attacking = true
	_player.animation_player.animation_finished.connect(end_attack)
	_player.apply_animation("attack")
	#player.splash_animation_player.play("Attack_" + player.anima_direction())
	#player.audio.stream = attack_sound
	#player.audio.pitch_scale = randf_range(0.9, 1.1)
	#player.audio.play()

	await get_tree().create_timer(0.075).timeout
	if attacking == true:
		pass
		#player.hurt_box.monitoring = true

func _exit() -> void:
	_player.animation_player.animation_finished.disconnect(end_attack)
	attacking = false
	#player.hurt_box.monitoring = false
	#set_deferred(player.hurt_box.monitoring, false)

func _update(delta: float) -> void:
	_player.velocity -= _player.velocity * decelerate_speed * delta
	#print("_update() attacking= ", attacking)
	#print("_update() _player.direction = ", _player.direction )
	if not attacking:
		if _player.direction == Vector2.ZERO:
			_player.hsm.dispatch("to_idle")
		else:
			_player.hsm.dispatch("to_move")

func end_attack(_data):
	attacking = false
