class_name State_Attack extends State

var attacking : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var attack_anim : AnimationPlayer = null # insert path to animation here

@onready var idle : State = $"../Idle"
@onready var walk : State = $"../Walk"
@onready var hurt_box : State = %AttackHurtBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# What happens when the player enters this state
func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_anim.play("attack_" + player.AnimDirection) # TODO, should be child of player sprite
	animation_player.animation_finished.connect( EndAttack ) # enter the EndAttack function when animation is finished
	
	attacking = true
	
	await get_tree().create_timer( 0.075 ).timeout # Can be changed
	
	hurt_box.monitoring = true

func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	
	hurt_box.monitoring = false
	
func Process( _delta : float ) -> State:
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else: 
			return walk
	return null
	
func Physics( _delta : float ) -> State:
	return null
	
func HandleInput( _input : InputEvent ) -> State:
	return null
		
func EndAttack( _newAnimName : String ) -> void:
	attacking = false # End attacking
	pass
