extends Node


const PLAYER = preload("res://Player/player.tscn")

var player : Player
var player_spawned : bool

func is_world() -> bool:
	if get_tree().current_scene.name == "res://World.tscn": 
		return true 
	else:
		return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !is_world:
		return
	player = PLAYER.instantiate()
	add_child( player )
	pass # Replace with function body.
