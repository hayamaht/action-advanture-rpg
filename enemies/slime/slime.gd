extends Enemy
class_name Slime

const PICKUP = preload("res://items/item_pickup.tscn")

@export_category("Setting")
@export var wander_speed := 20.0
@export var duration_min := 0.5
@export var duration_max := 1.5
@export var animation_duration := 0.5
@export var cycle_min := 1
@export var cycle_max := 3

@export_category("Item Drop")
@export var drops: Array[DropData]

@onready var idle_state: LimboState = $LimboHSM/Idle
@onready var move_state: LimboState = $LimboHSM/Walk
@onready var stun_state: LimboState = $LimboHSM/Stun
@onready var destroy_state: LimboState = $LimboHSM/Destroy

func _ready() -> void:
	player = PlayerManager.player
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

func drop_items() -> void:
	if drops.size() == 0: return

	for i in drops.size():
		if drops[i] == null or drops[i].item == null: continue
		var drop_count: int = drops[i].get_drop_count()
		for j in drop_count:
			var drop = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[i].item
			get_parent().call_deferred("add_child", drop)
			drop.global_position = global_position
			drop.velocity = velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)
