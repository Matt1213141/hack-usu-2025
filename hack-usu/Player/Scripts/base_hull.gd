class_name Hull extends Node2D

@export var hp : int
@export var max_hp : int
@export var velocity : Vector2
@export var speed_modifier : float

func initialize( hull_type : String ) -> void:
	# Set properties based on hull_type
	
	pass
	
func _physics_process(delta: float) -> void:
	velocity.y += delta
	var direction = Vector2.RIGHT
	velocity.x = 10
	
