extends CharacterBody2D
class_name Enemy

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT,  Vector2.UP]

signal dir_changed(new_dir: Vector2)
signal enemy_damaged(hunt_box: HurtBox)
signal enemy_destroyed(hunt_box: HurtBox)

@export_category("Setting")
@export var hp := 3
@export var wander_speed := 20.0
@export var duration_min := 0.5
@export var duration_max := 1.5
@export var animation_duration := 0.5
@export var cycle_min := 1
@export var cycle_max := 3

@onready var hsm: LimboHSM = $LimboHSM
@onready var idle_state: LimboState = $LimboHSM/Idle
@onready var move_state: LimboState = $LimboHSM/Walk
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	_init_state_machine()

func _init_state_machine() -> void:
	hsm.add_transition(hsm.ANYSTATE, move_state, "to_move")
	hsm.add_transition(hsm.ANYSTATE, idle_state, "to_idle")
	#hsm.add_transition(idle_state, attack_state, "to_attack")
	#hsm.add_transition(move_state, attack_state, "to_attack")

	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func apply_animation(state: String) -> void:
	animation_player.play(state + "_" + apply_dir())

func apply_movement(_delta: float) -> void:
	velocity = direction * wander_speed

func apply_direction() -> void:
	var rnd = randi_range(0, 3)
	var _dir = DIR_4[rnd]
	change_dir(_dir)

func apply_dir() -> String:
	if cardinal_direction == Vector2.UP: return "up"
	if cardinal_direction == Vector2.DOWN: return "down"
	return "side"

func get_rand_time() -> int:
	return randi_range(cycle_min, cycle_max) * animation_duration

func change_dir(dir: Vector2 = Vector2.ZERO) -> bool:
	direction = dir
	if direction == Vector2.ZERO: return false

	var dir_id = int( round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[dir_id]

	if new_dir == cardinal_direction: return false

	cardinal_direction = dir
	#dir_changed.emit(new_dir)
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1

	return true
