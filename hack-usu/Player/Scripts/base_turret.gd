class_name Turret extends Node2D

var fire_rate : float
var range : float
var damage : int

@export var Bullet : PackedScene
@export var bullet_speed : float = 750

@onready var muzzle = $Sprite2D/Marker2D
@onready var detection_area = $DetectionRange/CollisionShape2D

var enemies_in_range = []

func _ready():
	detection_area.body_entered.connect(_on_body_entered)
	detection_area.body_exited.connect(_on_body_exited)
	
func _process( delta : float ) -> void:
	var target = get_nearest_enemy()
	if target:
		look_at(target.global_position)
		
		shoot(target)
	pass
	
func shoot(target):
	var bullet = Bullet.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_transform = muzzle.global_transform
	bullet.rotation = global_rotation
	var direction = (target.global_position - global_position).normalized()
	bullet.velocity = Vector2.RIGHT.rotated(global_rotation) * bullet_speed
	
func initialize( turret_type : String ):
	# Set Properties based on turret type
	pass

func get_nearest_enemy():
	var nearest = null
	var nearest_distance = INF
	for enemy in enemies_in_range:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < nearest_distance:
			nearest = enemy
			nearest_distance = distance
	return nearest

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		enemies_in_range.append(body)
		
func _on_body_exited(body):
	if body.is_in_group("enemy"):
		enemies_in_range.erase(body)
