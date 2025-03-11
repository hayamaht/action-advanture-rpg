extends EnemyState
class_name GoblinState

var _enemy: Goblin

func _setup() -> void:
	_enemy = agent as Goblin
