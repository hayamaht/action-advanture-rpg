extends CanvasLayer

@onready var button_start: Button = %Button_Start
@onready var button_2_exit: Button = %Button2_Exit
@onready var version: Label = %Version

const SRART_LEVEL = preload("res://levels/level_area01.tscn")
var level_path = "res://levels/level_area01.tscn"

func _ready() -> void:
	version.text = "ver 0.7.5"
	button_start.grab_focus()

func _on_button_start_pressed() -> void:
	if not SaveManager.has_saving_file():
		LevelManager.load_new_level(level_path)
	else:
		SaveManager.load_game()

func _on_button_2_exit_pressed() -> void:
	get_tree().quit()
