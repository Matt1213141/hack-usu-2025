extends Node


const PLAYER = preload("res://Player/player.tscn")

var player : Player
var player_spawned : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = PLAYER.instantiate()
	add_child( player )
	pass # Replace with function body.
