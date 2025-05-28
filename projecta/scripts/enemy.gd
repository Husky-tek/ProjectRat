extends CharacterBody2D



enum States {IDLE,RUNNING,INAIR,DAMAGED,FASTFALL,CROUCH,DODGE}
enum lookat {RIGHT,LEFT}
enum action {IDLE, ATTACK, SPECIAL, MOVING}

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
