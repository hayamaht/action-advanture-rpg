extends Node2D
class_name Plant

func _on_hit_box_damaged(_hurt_box: HurtBox) -> void:
	queue_free()
