class_name Player extends CharacterBody2D

const TankManager = preload("res://Globals/tank_manager.gd")

# Load all variables from the tank manager class
var turret_type: String
var hull_type: String
var color: String
var tank_color: String

var speed_multiplier: float = 1.0
var armor_multiplier: float = 1.0
var fire_rate_multiplier: float = 1.0
var range_multiplier: float = 1.0	
var color_speed_multiplier: float = 1.0
var armor_multiplier_from_color: float = 1.0
# Other scripts have access by putting it at the root level of the script
var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
var direction : Vector2 = Vector2.ZERO

var invulnerable = false
var hp : int = 100 # It's a tank, so it might have a lot
var max_hp : int =  1000000000000000000

var max_speed : float = 100.0
var acceleration : float = 50.0

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player : AnimationPlayer = null # TODO INSERT PATH HERE

#@onready var hit_box : HitBox = $HitBox
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine

signal DirectionChanged( _new_direction : Vector2 )
signal player_damaged( hurt_box : HurtBox )

# Called when the player enters the scene for the first time
func _ready() -> void:
	# Failsafe: ensure the player is instantiated
	visible = false
	if PlayerManager.is_world():
		visible = true
	if PlayerManager.player == null:
		PlayerManager.player = self
	else:
		pass
	setup_tank_configuration()
	
	state_machine.Initialize( self )
	UpdateAnimation( "idle" )
	#update_hp(1000000) # Ensure player has full health when they spawn
	pass
	
func _physics_process( delta: float ) -> void:
	var target_velocity = direction * max_speed * speed_multiplier
	velocity = velocity.move_toward(target_velocity, acceleration * delta)#direction * $MovementComponent.speed * speed_multiplier
	var collision = move_and_collide( velocity * delta )
	if collision:
		direction = direction.bounce( collision.get_normal() )
		rotation = direction.angle()
	
func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		# no movement detected, don't change the direction
		return false
	
	var direction_id : int = int( round( ( direction + cardinal_direction  * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction: 
		return false
		
	cardinal_direction = new_dir
	
	DirectionChanged.emit( new_dir )
	
	sprite.scale.x - -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func UpdateAnimation( state : String ) -> void:
	animation_player.play( state + "_" + anim_direction() )
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true: 
		return # tank is invulnerable, can't take damage
	update_hp( -hurt_box.damage )
	if hp > 0:
		player_damaged.emit( hurt_box )
	else:
		player_damaged.emit( hurt_box )
		queue_free() # Remove the tank from the scene
	
func update_hp( delta : int ) -> void: 
	hp = clampi( hp + delta, 0, max_hp)

func setup_tank_configuration() -> void:
	speed_multiplier = get_speed_multiplier(hull_type)
	armor_multiplier = get_armor_multiplier(hull_type)
	color_speed_multiplier = get_speed_multiplier_from_color(color)
	armor_multiplier_from_color = get_armor_multiplier_from_color(color)
	
func apply_tank_configuration() -> void:
	# Apply stat changes here
	max_hp *= armor_multiplier * armor_multiplier_from_color
	hp = max_hp
	max_speed *= speed_multiplier * color_speed_multiplier
	
	# Apply all visual loads here
	if sprite:
		sprite.modulate = Color(color)

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

func get_armor_multiplier_from_color( color : String ) -> int:
	if color == "Brown" || color == "Turquoise":
		return 1
	else: 
		return 2
