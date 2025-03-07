extends CanvasLayer

@onready var h_flow_container: HFlowContainer = $Control/HFlowContainer

var hearts: Array[HeartGUI] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in h_flow_container.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false


func update_hp(hp: int, max_hp: int) -> void:
	_update_max_hp(max_hp)
	for i in max_hp:
		_update_heart(i, hp)


func _update_heart(index: int, hp: int) -> void:
	var v = clampi(hp - index * 2, 0, 2)
	hearts[index].value = v

func _update_max_hp(max_hp: int) -> void:
	var heart_count = roundi(max_hp * 0.5)
	for i in hearts.size():
		hearts[i].visible = true if i < heart_count else false
