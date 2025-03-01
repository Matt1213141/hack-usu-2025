class_name BaseTank extends CharacterBody2D

@export var hull: Node2D
@export var turret: Node2D
@export var color: String

var input_vector : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.RIGHT
var speed : float = 100.0

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

func swap_hull(new_hull_scene: PackedScene):
	var new_hull = new_hull_scene.instantiate()
	hull.replace_by(new_hull)
	hull = new_hull

func swap_turret(new_turret_scene: PackedScene):
	var new_turret = new_turret_scene.instantiate()
	turret.replace_by(new_turret)
	turret = new_turret
