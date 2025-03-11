class_name PushableStatue
extends RigidBody2D

@export var push_speed := 30.0

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var push_dir = Vector2.ZERO : set = _set_push

func _physics_process(_delta: float) -> void:
	linear_velocity = push_dir * push_speed

func _set_push(value: Vector2) -> void:
	push_dir = value
	if push_dir == Vector2.ZERO:
		audio_stream_player_2d.stop()
	else:
		audio_stream_player_2d.play()
