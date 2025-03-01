class_name BaseTank extends CharacterBody2D

@export var hull: Node2D
@export var turret: Node2D
@export var color: String

@onready var hull_container = $BaseHull
@onready var turret_container = $BaseTurret

var input_vector : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.RIGHT
var speed : float = 100.0

var current_hull: Node2D
var current_turret: Node2D

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

func set_hull(new_hull_scene: PackedScene):
	if current_hull:
		current_hull.set_queue_free()
	current_hull = new_hull_scene.instantiate()
	hull_container.add_child(current_hull)

func set_turret(new_turret_scene: PackedScene):
	if current_turret:
		current_turret.set_queue_free()
	current_turret = new_turret_scene.instantiate()
	turret_container.add_child(current_turret)
	
