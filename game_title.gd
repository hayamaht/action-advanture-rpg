extends CanvasLayer

@onready var button_start: Button = %Button_Start
@onready var button_2_exit: Button = %Button2_Exit
@onready var version: Label = %Version

const SRART_LEVEL = preload("res://levels/level_area01.tscn")

func _ready() -> void:
	version.text = "ver 0.7.5"

func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_packed(SRART_LEVEL)

func _on_button_2_exit_pressed() -> void:
	get_tree().quit()
