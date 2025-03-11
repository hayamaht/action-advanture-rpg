extends GoblinState

var _dir: Vector2
var _animation_finished := false
var _damage_pos: Vector2 = Vector2.ZERO

func _enter() -> void:
	_enemy.invulnerable = true
	_animation_finished = false
	_dir = _enemy.global_position.direction_to(_damage_pos)
	_enemy.change_dir(_dir)
	_enemy.velocity = _dir * -_enemy.knockback_speed
	_enemy.apply_animation(STUN)

func _exit() -> void:
	_enemy.invulnerable = false

func _update(delta: float) -> void:
	_enemy.velocity -= _enemy.velocity * _enemy.desclerate_speed * delta

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	_animation_finished = true
	dispatch(TO_CHASE)

func _on_goblin_enemy_damaged(hurt_box: HurtBox) -> void:
	_damage_pos = hurt_box.global_position

func _on_goblin_enemy_destroyed(_hurt_box: HurtBox) -> void:
	dispatch(TO_DESTROY)
