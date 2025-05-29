extends CharacterBody2D



enum States {IDLE,WALKING,INAIR,DAMAGED,FASTFALL,CROUCH,DODGE}
enum lookat {RIGHT,LEFT}
enum action {IDLE, ATTACK, SPECIAL, MOVING}

var HP = 10
var Attack = 0.0
var speed = 1

var currState = States.IDLE
var look = lookat.RIGHT
var curAction = action.IDLE

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		currState = States.INAIR
	

func take_damage(damage):
	HP -= damage
	currState = States.DAMAGED
