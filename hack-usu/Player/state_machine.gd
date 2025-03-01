class_name PlayerStateMachine extends Node


var states : Array[ State ]
var prev_state: State
var current_state: State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#ChangeState( current_state.Process( delta ) ) # Checks every frame if the state has changed
	pass
