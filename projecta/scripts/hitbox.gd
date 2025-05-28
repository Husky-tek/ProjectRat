extends Area2D

var damage = get_parent().attack

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	pass # Replace with function body.
