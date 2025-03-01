class_name Player extends CharacterBody2D

# Other scripts have access by putting it at the root level of the script
var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
var direction : Vector2 = Vector2.ZERO

var invulnerable = false
var hp : int = 100 # It's a tank, so it might have a lot
var max_hp : int =  1000000000000000000

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player : AnimationPlayer = null # TODO INSERT PATH HERE

@onready var hit_box : HitBox = $HitBox
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine

signal DirectionChanged( _new_direction : Vector2 )
signal player_damaged( hurt_box : HurtBox )

# Called when the player enters the scene for the first time
func _ready() -> void:
	# Failsafe: ensure the player is instantiated
	if PlayerManager.player == null:
		PlayerManager.player = self
	else:
		pass
		
	state_machine.Initialize(self)
	hit_box.Damaged.connect( _take_damage )
	update_hp(1000000) # Ensure player has full health when they spawn
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta : float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
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
