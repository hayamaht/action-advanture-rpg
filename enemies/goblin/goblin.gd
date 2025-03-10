class_name Goblin
extends Enemy

@export_category("Setting")
@export var walk_speed := 20.0
@export var chase_speed := 50.0
@export var duration_min := 0.5
@export var duration_max := 1.5

@onready var chase_state: LimboState = $LimboHSM/Chase

func _ready() -> void:
	player = PlayerManager.player
	_init_state_machine()

func _init_state_machine() -> void:
	hsm.add_transition(hsm.ANYSTATE, move_state, EnemyState.TO_WALK)
	hsm.add_transition(hsm.ANYSTATE, idle_state, EnemyState.TO_IDLE)
	hsm.add_transition(idle_state, stun_state, EnemyState.TO_STUN)
	hsm.add_transition(move_state, stun_state, EnemyState.TO_STUN)
	hsm.add_transition(hsm.ANYSTATE, chase_state, EnemyState.TO_CHASE)
	hsm.add_transition(hsm.ANYSTATE, destroy_state, EnemyState.TO_DESTROY)

	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func apply_movement(_delta: float) -> void:
	velocity = direction * walk_speed

func get_rand_duration() -> float:
	return randf_range(duration_min, duration_max)
