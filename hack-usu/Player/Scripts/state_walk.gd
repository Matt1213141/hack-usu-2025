class_name StateWalk extends State


@onready var idle : State = $"../Idle"
@onready var attack : State = $"../Attack"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Enter() -> void:
	#player.UpdateAnimation("walk")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * player.velocity
	
	if player.SetDirection():
		#player.UpdateAnimation("walk")
		pass
	return null

func Physics( _delta : float ) -> State:
	return null
	
func HandleInput( _event : InputEvent ) -> State:
	return
