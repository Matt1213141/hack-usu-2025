class_name Bullet extends Area2D

var velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += velocity * delta
	
func _on_body_entered(body):
	if body.is_in_group("targets"):
		body.take_damage(10)
	queue_free()
