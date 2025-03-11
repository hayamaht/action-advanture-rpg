class_name VisionArea
extends Area2D

signal player_entered
signal player_exited

func _ready() -> void:
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)

	var p = get_parent()
	if p is Enemy:
		p.dir_changed.connect(_on_dir_changed)


func _on_body_entered(_body: Node2D) -> void:
	if _body is Player:
		player_entered.emit()


func _on_body_exited(_body: Node2D) -> void:
	if _body is Player:
		player_exited.emit()

func _on_dir_changed(new_dir: Vector2) -> void:
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
