extends Node

const CHILD_ID = 3

const PLAYER = preload("res://player/player.tscn")
#const INVENTORY_DATA: InventoryData = preload("res://resources/player_inventory.tres")

var player: Player
var player_spawned := false

#signal interact_pressed

func _ready():
	add_player_instance()

#func get_scene() -> Node:
	#for i in get_parent().get_children():
		#print(i)
	#return get_node("Level-")

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	#get_parent().get_child(CHILD_ID).add_child(player)
	add_child(player)
	await get_tree().create_timer(0.2).timeout
	player_spawned = true

func set_health(hp: int, max_hp: int) -> void:
	player.max_hp = max_hp
	player.hp = hp if hp <= player.max_hp else player.max_hp
	player.update_hp(0)

func set_player_position(new_pos: Vector2) -> void:
	player.global_position = new_pos

func set_as_parent(node: Node2D):
	if player.get_parent():
		player.get_parent().remove_child(player)
	node.add_child(player)


func unparent_player(node: Node2D):
	node.remove_child(player)


func play_audio( audio: AudioStream) -> void:
	player.audio.stream = audio
	player.audio.play()
