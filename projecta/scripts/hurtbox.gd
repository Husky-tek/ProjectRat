class_name hurtbox
extends Area2D

signal recieved_damage(damage: int)


func _on_area_entered(hitbox: hitbox) -> void:
	if hitbox != null:
		health.health -= hitbox.damage
		recieved_damage.emit(hitbox.damage)
