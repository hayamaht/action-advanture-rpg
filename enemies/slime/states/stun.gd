extends EnemyState

var _dir: Vector2
var _animation_finished := false
var _damage_position: Vector2

func _enter() -> void:
	_enemy.invulnerable = true
	_animation_finished = false
	_dir = _enemy.global_position.direction_to(_damage_position)
	_enemy.change_dir(_dir)
	_enemy.velocity = _dir * -_enemy.knockback_speed
	_enemy.apply_animation("stun")

func exit() -> void:
	_enemy.invulnerable = false

func _update(delta: float) -> void:
	_enemy.velocity -= _enemy.velocity * _enemy.desclerate_speed * delta

	if _animation_finished == true:
		dispatch("to_idle")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	_animation_finished = true
