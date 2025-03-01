class_name HurtBox extends Area2D

@export var damage : int = 1 # Doesn't matter what this value is, we can change it depending on the player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Detect if something enters the current area
	area_entered.connect( AreaEntered )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func AreaEntered( a : Area2D ):
	if a is HitBox:
		a.TakeDamage( self )
