class_name Bullet extends Area2D

var velocity = Vector2.ZERO

@onready var sprite = $Sprite2D
@onready var impact_animation = $Sprite2D/DestroyEffectSprite


func _ready() -> void:
	impact_animation.visible = false
	body_entered.connect(_on_bullet_collision)
	
func _physics_process(delta: float) -> void:
	position += velocity * delta

func _on_bullet_collision(body):
	sprite.visible = false
	impact_animation.visible = true
	impact_animation.play("impact")
	
	# Wait for animation to finish playing
	await impact_animation.animation_finished
	
	# Now we can remove the sprite 
	queue_free()
	
func _on_body_entered(body):
	if body.is_in_group("targets"):
		body.take_damage(10)
	queue_free()
