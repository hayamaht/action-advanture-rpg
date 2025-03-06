class_name HurtBox extends Area2D

#@export var damage := 1

func _on_area_entered(area: Area2D) -> void:
	if area is not HitBox: return
	area.take_damage(self)
