class_name DropData
extends Resource

@export var item: ItemData
@export_range(0, 100, 1, "suffix:%") var probability := 100.0
@export_range(1, 10, 1, "suffix:items") var min_amount := 1
@export_range(1, 10, 1, "suffix:items") var max_amount := 1

func get_drop_count() -> int:
	if randf_range(0, 100) >= probability: return 0
	var count = randi_range(min_amount, max_amount)
	return count
