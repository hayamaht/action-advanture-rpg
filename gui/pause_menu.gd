##
## Node.mode = PRECESS_MODE_ALWAYS
##

extends CanvasLayer

signal shown
signal hidden

@onready var button_save: Button = $MarginContainer/VBoxContainer2/VBoxContainer/Button_Save
@onready var button_load: Button = $MarginContainer/VBoxContainer2/VBoxContainer/Button_Load

#@onready var item_desc: Label = $Control/ItemDesc
#@onready var audio_stream_player: AudioStreamPlayer = $Control/AudioStreamPlayer


enum { HIDE, SHOW }
enum { SAVE, LOAD }
var is_paused := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggle_pause_menu(HIDE)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var t = SHOW if is_paused == false else HIDE
		toggle_pause_menu(t)
		get_viewport().set_input_as_handled()

func toggle_pause_menu(type := HIDE) -> void:
	var t = false if type == HIDE else true
	get_tree().paused = t
	visible = t
	is_paused = t
	button_save.grab_focus()
	if type == SHOW: shown.emit()
	else: hidden.emit()

func play_audio(sound: AudioStream) -> void:
	pass
	#audio_stream_player.stream = sound
	#audio_stream_player.play()

func _keep_data(type):
	if type == SAVE:
		SaveManager.save_game()
	else:
		SaveManager.load_game()


func update_item_desc(s: String) -> void:
	pass
	#item_desc.text = s

func _on_button_save_pressed() -> void:
	if not is_paused: return
	_keep_data(SAVE)
	toggle_pause_menu(HIDE)


func _on_button_load_pressed() -> void:
	if not is_paused: return
	_keep_data(LOAD)
	await LevelManager.level_load_started
	toggle_pause_menu(HIDE)
