class_name HitBox extends Area2D

signal Damaged( hurt_box : HurtBox ) 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func take_damage( hurt_box : HurtBox ):
	Damaged.emit( hurt_box )
