extends Area2D

@onready var lmao = $Node2D/CharacterBody2D

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1,100,global_position)
	else:
		print("lmao")
	pass # Replace with function body.

func take_damage():
	print("lmao")
