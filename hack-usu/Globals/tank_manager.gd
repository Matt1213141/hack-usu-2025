extends Node

var turrets : Array[ String ] = ["LMG", "MAP", "Grenade", "Sniper"]
var hulls : Array[ String ] = ["Light", "Mid-light", "Mid-heavy", "Heavy"]
var colors  : Array[ String ] = ["Brown", "Green", "Turquoise", "Blue"]
var speed_multipliers : Array[ int ] = [2, 1, 2, 1]
var armor_multipliers : Array [ int ] =  [1, 2, 1, 2]
var fire_rate_multiplier : Array [ int ] = [2, 1, 2, 1]
var range_mutliplier : Array [ int ] =  [1, 2, 1, 2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
