extends LimboState
class_name EnemyState

var _enemy: Enemy

func _setup() -> void:
	_enemy = agent as Enemy
