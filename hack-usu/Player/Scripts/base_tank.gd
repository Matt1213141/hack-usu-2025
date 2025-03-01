class_name BaseTank extends CharacterBody2D

@export var hull_scene: PackedScene
@export var turret_scene: PackedScene
@export var color: String

@onready var hull_container = $BaseHull
@onready var turret_container = $BaseTurret

var input_vector : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.RIGHT
var speed : float = 1000.0

var current_hull: Node2D
var current_turret: Node2D

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	
	# Detect Collision 
	var collision = move_and_collide( velocity * delta )
	
	if collision:
		# Calculate the bounce direction
		direction = direction.bounce( collision.get_normal() ) * randf_range(.6,1.4)
		
		# Rotate the tank to face the new direction
		rotation = direction.angle()
		
func _ready():
	# Set initial rotation
	rotation = direction.angle()
	set_hull(hull_scene)
	set_turret(turret_scene)
	apply_color()

func set_hull(new_hull_scene: PackedScene):
	if current_hull:
		current_hull.queue_free()
	if new_hull_scene:
		current_hull = new_hull_scene.instantiate()
		hull_container.add_child(current_hull)

func set_turret(new_turret_scene: PackedScene):
	if current_turret:
		current_turret.queue_free()
	if new_turret_scene:
		current_turret = new_turret_scene.instantiate()
		turret_container.add_child(current_turret)
	
func apply_color():
	if current_hull:
		current_hull.modulate = color
	if current_turret:
		current_turret.modulate = color
