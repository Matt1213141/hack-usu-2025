class_name BaseTank extends CharacterBody2D

export var armor = 60
export var velocity = 200
export var turret_rotation_speed = 3.0

@export var hull = $Hull
@export var turret = $Turret

var input_vector = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	
	# Detect Collision 
	var collision = move_and_collide( velocity * delta )
	
	if collision:
		# Calculate the bounce direction
		direction = direction.bounce( collision.get_normal() )
		
		# Rotate the tank to face the new direction
		rotation = direction.angle()
		
func _ready():
	# Set initial rotation
	rotation = direction.angle()
