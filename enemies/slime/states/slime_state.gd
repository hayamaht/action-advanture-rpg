extends LimboState
class_name SlimeState

const IDLE = "idle"
const WALK = "walk"
const STUN = "stun"
const DESTROY = "destroy"
const TO_IDLE = "to_idle"
const TO_WALK = "to_walk"
const TO_STUN = "to_stun"
const TO_DESTROY = "to_destroy"

var _enemy: Slime

func _setup() -> void:

	_enemy = agent as Slime
