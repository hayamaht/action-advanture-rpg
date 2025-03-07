extends PlayerState

var _hurt_box: HurtBox
var _dir: Vector2

func _enter() -> void:
	_dir = _player.global_position.direction_to(_hurt_box.global_position)
	_player.change_dir()
	_player.apply_animation(PlayerState.STUN)
	_player.velocity = _dir * -_player.knockback_speed
	_player.make_invulnerable( _player.invulnerable_duration )
	_player.efx_animation_player.play("damaged")

func _update(delta: float) -> void:
	_player.velocity -= _player.velocity * _player.decelerate_speed * delta


func _on_player_player_damaged(hurt_box: HurtBox) -> void:
	_hurt_box = hurt_box
	dispatch(PlayerState.TO_STUN)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	dispatch(PlayerState.TO_IDLE)
