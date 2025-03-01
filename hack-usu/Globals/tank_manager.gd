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

func get_speed_multiplier( type : String ) -> int:
	if type == "Light": 
		return 2
	elif type == "Mid-light":
		return 1.5
	elif type == "Mid-heavy":
		return 1.2
	else:
		return 1.0
		
func get_speed_multiplier_from_color( color : String ) -> int:
	if color == "Brown" || color == "Turquoise":
		return 2
	else:
		return 1

func get_armor_multiplier( hull : String ) -> int:
	if hull == "Light":
		return 1
	elif hull == "Mid-light":
		return 1.2
	elif hull == "Mid-heavy":
		return 1.5
	else:
		return 2
