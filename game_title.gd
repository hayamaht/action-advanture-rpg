extends CanvasLayer

@onready var button_start: Button = %Button_Start
@onready var button_2_exit: Button = %Button2_Exit
@onready var version: Label = %Version

const SRART_LEVEL = preload("res://levels/level_area01.tscn")

func _ready() -> void:
	version.text = "ver 0.7.5"
	button_start.grab_focus()

func _on_button_start_pressed() -> void:
	#get_tree().change_scene_to_packed(SRART_LEVEL)
	LevelManager.load_new_level("res://levels/level_area01.tscn", "", Vector2.ZERO)

func _on_button_2_exit_pressed() -> void:
	get_tree().quit()
