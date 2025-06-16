extends Area2D



func _on_hitbox_body_entered(body: Node2D) -> void:
	print("hitbox entered")
	if owner.has_method("take_damage"):
		print("method found")
	pass # Replace with function body.

func take_damage():
	print("lmao")
