class_name PressurePlate
extends Node2D

signal activated
signal deactivated

var bodies := 0
var is_active := false
var off_rect: Rect2

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_activate := preload("res://assets/audio/Lever.wav")
@onready var audio_deactivate := preload("res://assets/audio/Lever_2.wav")

func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	off_rect = sprite_2d.region_rect

func _on_body_entered(_body: Node2D) -> void:
	bodies += 1
	check_is_activated()

func _on_body_exited(_body: Node2D) -> void:
	bodies -= 1
	check_is_activated()

func check_is_activated() -> void:
	if bodies > 0 and is_active == false:
		is_active = true
		sprite_2d.region_rect.position.x = off_rect.position.x - 32
		play_audio(audio_activate)
		activated.emit()
	elif bodies <= 0 and is_active == true:
		is_active = false
		sprite_2d.region_rect.position.x = off_rect.position.x
		play_audio(audio_deactivate)
		deactivated.emit()

func play_audio(steam: AudioStream) -> void:
	audio_stream_player_2d.stream = steam
	audio_stream_player_2d.play()
