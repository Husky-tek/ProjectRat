extends CharacterBody2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	

	move_and_slide()


func trap_trigger(area: Area2D) -> void:
	print(area.get_name())
	pass # Replace with function body.
