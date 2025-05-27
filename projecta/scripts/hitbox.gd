class_name hitbox
extends CharacterBody2D

const speed=1000
@export var Projectile: PackedScene

var mynode = preload("res://Prefabs/hitbox.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	position += transform.x * (speed * delta)
	pass
