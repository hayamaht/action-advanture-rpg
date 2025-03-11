extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(_body: Node2D) -> void:
	if _body is PushableStatue:
		_body.push_dir = PlayerManager.player.direction

func _on_body_exited(_body: Node2D) -> void:
	if _body is PushableStatue:
		_body.push_dir = Vector2.ZERO
