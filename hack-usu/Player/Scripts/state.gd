class_name State extends Node

# This class is mostly an interface for all states that are available
static var player : Player
static var state_machine : PlayerStateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init() -> void:
	pass 

# What happens when the player enters the state? 
func Enter() -> void:
	pass
	
# What happens when the player exits the state
func Exit() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func Process(delta: float) -> State:
	return null

func Physics( _delta : float ) -> State:
	return null
	
func HandleInput( _event : InputEvent ) -> State:
	return null
