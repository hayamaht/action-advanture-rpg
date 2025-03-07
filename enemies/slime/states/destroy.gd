extends EnemyState

#const PICKUP = preload("res://sceens/gui/item_pickup.tscn")


var _dir: Vector2
var _damage_position: Vector2

func _enter() -> void:
	_dir = _enemy.global_position.direction_to(_damage_position)
	_enemy.change_dir(_dir)
	_enemy.velocity = _dir * -_enemy.knockback_speed
	_enemy.apply_animation("destroy")
	_disable_hurt_box()
	#drop_items()

func _update(delta) -> void:
	_enemy.velocity -= _enemy.velocity * _enemy.desclerate_speed * delta

func _disable_hurt_box() -> void:
	var hurt_box: HurtBox = _enemy.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false

#func drop_items() -> void:
	#if drops.size() == 0: return
#
	#for i in drops.size():
		#if drops[i] == null or drops[i].item == null: continue
		#var drop_count: int = drops[i].get_drop_count()
		#for j in drop_count:
			#var drop = PICKUP.instantiate() as ItemPickup
			#drop.item_data = drops[i].item
			#enemy.get_parent().call_deferred("add_child", drop)
			#drop.global_position = enemy.global_position
			#drop.velocity = enemy.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)
	#pass

func _on_slime_enemy_destroyed(_hunt_box: HurtBox) -> void:
	dispatch("to_destroy")


func _on_slime_enemy_damaged(hunt_box: HurtBox) -> void:
	_damage_position = hunt_box.global_position


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if _enemy.hp <= 0:
		_enemy.queue_free()
