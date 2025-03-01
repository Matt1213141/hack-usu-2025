class_name StateIdle extends State

@onready var walk : State = $"../Walk"
@onready var attack : State = $"../Attack"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# What happens when we call this function?
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

func Exit() -> void:
	pass
	
func Process( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
