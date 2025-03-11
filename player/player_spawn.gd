extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	if PlayerManager.player_spawned: return
	print(self.global_position)
	PlayerManager.set_player_position(global_position)
	PlayerManager.player_spawned = true
