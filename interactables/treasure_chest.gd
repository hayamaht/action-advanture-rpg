@tool
class_name TreasureChest
extends Node2D

@export var item_data: ItemData : set = _set_item_data
@export_range(1, 99, 1) var quantity: int = 1 : set = _set_quantity

@onready var sprite_2d: Sprite2D = $ItemSprite
@onready var label: Label = $ItemSprite/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_area: Area2D = $Area2D
#@onready var is_open_data: PersistentDataHandler = $IsOpen


var is_open := false

func _ready() -> void:
	_update_texture()
	_update_label()
	if Engine.is_editor_hint(): return
	#is_open_data.data_loaded.connect(_on_is_open_data_loaded)
	_on_is_open_data_loaded()

func _set_item_data(value: ItemData) -> void:
	item_data = value
	_update_texture()
	pass

func _set_quantity(value: int) -> void:
	quantity = value
	_update_label()
	pass

func _update_texture() -> void:
	if item_data == null or sprite_2d == null: return
	sprite_2d.texture = item_data.texture

func _update_label() -> void:
	if label == null: return
	label.text = "x" + str(quantity) if quantity > 1 else ""

func _on_interact_pressed() -> void:
	if is_open == true: return
	is_open = true
	#is_open_data.set_value()
	animation_player.play("opening")
	if item_data and quantity >= 1:
		PlayerManager.INVENTORY_DATA.add_item(item_data, quantity)
	else:
		printerr("No item in the chest")

func _on_area_2d_area_entered(_area: Area2D) -> void:
	PlayerManager.interact_pressed.connect(_on_interact_pressed)

func _on_area_2d_area_exited(_area: Area2D) -> void:
	PlayerManager.interact_pressed.disconnect(_on_interact_pressed)

func _on_is_open_data_loaded() -> void:
	#is_open = is_open_data.value
	if is_open:
		animation_player.play("opened")
	else:
		animation_player.play("closed")
