extends CharacterBody2D
class_name Player

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT,  Vector2.UP]

@export_category("Setting")
@export var hp := 6
@export var max_hp := 6
@export var invulnerable_duration := 1.0
@export var knockback_speed := 500.0

@export_category("Movement")
@export var move_speed := 100.0

@export_category("Attack")
@export_range(1, 20, 0.5) var decelerate_speed := 15.0
@export var attack_sound: AudioStream

@onready var hsm: LimboHSM = $LimboHSM
@onready var idle_state: LimboState = $LimboHSM/Idle
@onready var move_state: LimboState = $LimboHSM/Walk
@onready var attack_state: LimboState = $LimboHSM/Attack
@onready var stun_state: LimboState = $LimboHSM/Stun

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var splash_animation_player: AnimationPlayer = $Sprite2D/AttackEfxSprite/AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer2D = $Audio/AudioStreamPlayer2D
@onready var hurt_box: HurtBox = $Sprite2D/AttackHurtBox
@onready var interactions: Node2D = $Interactions
@onready var hit_box: HitBox = $HitBox
@onready var efx_animation_player: AnimationPlayer = $EfxAnimationPlayer

signal dir_changed(new_dir: Vector2)
signal player_damaged(hurt_box: HurtBox)

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var movement_input: Vector2 = Vector2.ZERO
var invulnerable := false


func _ready() -> void:
	PlayerManager.player = self
	_init_state_machine()
	update_hp(max_hp)

func _init_state_machine() -> void:
	hsm.add_transition(hsm.ANYSTATE, move_state, PlayerState.TO_WALK)
	hsm.add_transition(hsm.ANYSTATE, idle_state, PlayerState.TO_IDLE)
	hsm.add_transition(idle_state, attack_state, PlayerState.TO_ATTACK)
	hsm.add_transition(move_state, attack_state, PlayerState.TO_ATTACK)
	hsm.add_transition(hsm.ANYSTATE, stun_state, PlayerState.TO_STUN)

	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func apply_animation(state: String) -> void:
	animation_player.play(state + "_" +apply_dir())

func apply_movement(_delta: float) -> void:
	velocity = direction * move_speed

func apply_decelerate(delta: float) -> void:
	velocity -= velocity * decelerate_speed * delta

func apply_attack() -> void:
	apply_animation("attack")
	splash_animation_player.play("attack_" + apply_dir())
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()

func apply_hurt_box(toggle: bool) -> void:
	hurt_box.monitoring = toggle

func apply_rotation(new_dir: Vector2) -> void:
	match new_dir:
		Vector2.DOWN:
			interactions.rotation_degrees = 0
			#position = Vector2(0, 5)
		Vector2.UP:
			interactions.rotation_degrees = 180
			#position = Vector2(0, -25)
		Vector2.LEFT:
			interactions.rotation_degrees = 90
			#position = Vector2(-19, -13)
		Vector2.RIGHT:
			interactions.rotation_degrees = -90
			#position = Vector2(19, -13)
		_:
			interactions.rotation_degrees = 0


func apply_dir() -> String:
	if cardinal_direction == Vector2.UP: return "up"
	if cardinal_direction == Vector2.DOWN: return "down"
	return "side"

func change_dir() -> bool:
	if direction == Vector2.ZERO: return false

	var dir_id = int( round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[dir_id]

	if new_dir == cardinal_direction: return false

	cardinal_direction = new_dir
	dir_changed.emit(new_dir)
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1

	return true

func update_hp(delta: int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	Hud.update_hp(hp, max_hp)

func make_invulnerable(duration: float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	await get_tree().create_timer(duration).timeout
	invulnerable = false
	hit_box.monitoring = true


func _on_hit_box_damaged(_hurt_box: HurtBox) -> void:
	if invulnerable == true: return
	update_hp(-_hurt_box.damage)

	if hp > 0:
		print("player hp= ", hp)
		player_damaged.emit(hurt_box)
	else:
		print("// game over!!!")
		player_damaged.emit(hurt_box)
		update_hp(max_hp)
