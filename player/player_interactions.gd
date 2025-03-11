class_name PlayerInteractions
extends Node2D

@onready var player: Player = $".."

func _ready():
	player.dir_changed.connect(update_dir)

func update_dir(new_dir: Vector2):
	match new_dir:
		Vector2.DOWN:
			rotation_degrees = 0
			#position = Vector2(0, 5)
		Vector2.UP:
			rotation_degrees = 180
			#position = Vector2(0, -25)
		Vector2.LEFT:
			rotation_degrees = 90
			#position = Vector2(-19, -13)
		Vector2.RIGHT:
			rotation_degrees = -90
			#position = Vector2(19, -13)
		_:
			rotation_degrees = 0
