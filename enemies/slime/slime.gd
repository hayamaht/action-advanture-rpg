extends Enemy
class_name Slime

@export_category("Setting")
@export var wander_speed := 20.0
@export var duration_min := 0.5
@export var duration_max := 1.5
@export var animation_duration := 0.5
@export var cycle_min := 1
@export var cycle_max := 3

@onready var idle_state: LimboState = $LimboHSM/Idle
@onready var move_state: LimboState = $LimboHSM/Walk
@onready var stun_state: LimboState = $LimboHSM/Stun
@onready var destroy_state: LimboState = $LimboHSM/Destroy

func _ready() -> void:
	_init_state_machine()

func _init_state_machine() -> void:
	hsm.add_transition(hsm.ANYSTATE, move_state, SlimeState.TO_WALK)
	hsm.add_transition(hsm.ANYSTATE, idle_state, SlimeState.TO_IDLE)
	hsm.add_transition(idle_state, stun_state, SlimeState.TO_STUN)
	hsm.add_transition(move_state, stun_state, SlimeState.TO_STUN)
	hsm.add_transition(hsm.ANYSTATE, destroy_state, SlimeState.TO_DESTROY)

	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func apply_movement(_delta: float) -> void:
	velocity = direction * wander_speed

func get_rand_duration() -> float:
	return randf_range(duration_min, duration_max)

func get_rand_cycle() -> float:
	return randf_range(cycle_min, cycle_max) * animation_duration
