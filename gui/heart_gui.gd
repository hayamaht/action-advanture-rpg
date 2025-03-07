extends Control
class_name HeartGUI

@onready var sprite_2d: Sprite2D = $Sprite2D

enum HEART_VAL { EMPTY, HALF, FULL }

var value = 2:
	set(v):
		value = v
		update_heart()


func update_heart() -> void:
	sprite_2d.frame = value
