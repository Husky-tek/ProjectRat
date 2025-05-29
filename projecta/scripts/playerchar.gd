extends CharacterBody2D

@export var play:Player

var primary:attackClass


var SPEED = 300.0
var JUMP_VELOCITY = -400.0
var knockback = 0.0
var defence = 0.0
var attack = 0.0
var speed = 0.0
var critDmg = attack * 2
var critRate = 0.0
var jump_count = 0
var jump_Toggle = true
var fast_fall = 0
var lives = 3
@onready var time = $DodgeTimer2
@onready var atktime = $Attacktimer

#spawn hitboxes
var MyNode = preload("res://characters/Rat/Hitboxs/hitbox.tscn")
var instance = MyNode.instantiate()

#player States
enum States {IDLE,RUNNING,INAIR,DAMAGED,FASTFALL,CROUCH,DODGE}
enum lookat {RIGHT,LEFT}
enum action {IDLE, ATTACK, SPECIAL, MOVING}
var look = lookat.RIGHT
var state = States.IDLE
var currAction = action.IDLE


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		state = States.INAIR
	
		
	
	if Input.is_action_pressed("ui_down") and is_on_floor():
		state = States.CROUCH
	if Input.is_action_just_released("ui_down"):
		state = States.IDLE
		
	if Input.is_action_just_pressed("Attack_control"):
		currAction = action.ATTACK
		atk()
	
	if Input.is_action_just_pressed("Special_Attack_control"):
		Satk()
	
	if Input.is_action_just_pressed("dodge"):
		dodge()
		
		
	if Input.is_action_pressed("ui_down") and is_on_floor():
		state = States.CROUCH
		
	if jump_count ==  1:
		jump_Toggle = false

	#add limits to jumping
	if Input.is_action_just_pressed("ui_accept"):
		jump()

	if is_on_floor():
		jump_Toggle = true
		jump_count = 0
		state = States.IDLE
		
	

	if  Input.is_action_just_pressed("ui_down") and not is_on_floor():
		state = States.FASTFALL
		print("fast fall on")
		velocity.y = 350
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		state = States.RUNNING
		if Input.is_action_pressed("ui_left"):
			currAction = action.MOVING
			look = lookat.LEFT
		if Input.is_action_pressed("ui_right"):
			currAction = action.MOVING
			look = lookat.RIGHT
		velocity.x = direction * SPEED
	else:
		if Input.is_action_just_released("ui_left") or  Input.is_action_just_released("ui_right") :
			state = States.IDLE
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func atk ():
	
	if state == States.IDLE:
		match look:
			lookat.RIGHT:
				print("attck IDLE RIGHT")
			lookat.LEFT:
				print("atk IDLE LEFT")
	if state == States.RUNNING:
		match look:
			lookat.RIGHT:
				print("attck RUNNING RIGHT")
			lookat.LEFT:
				print("atk RUNNING LEFT")
	elif state == States.CROUCH:
		match look:
			lookat.RIGHT:
				print("atk CROUCH RIGHT")
			lookat.LEFT:
				print("atk CROUCH LEFT")
	elif state == States.INAIR:
		print("aireal")
	else:
		print("what the fuck")
			
func Satk():
	
	add_child(instance)
	atktime.start()



func jump():
	if jump_Toggle:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	if Input.is_action_just_released("ui_accept"):
		print("released")
		if velocity.y < -50:
			velocity.y  = -50

func dodge():
	if time.time_left == 0:
		state = States.DODGE
		time.start()
		print("dodge")



func _on_dodge_timer_2_timeout() -> void:
	state = States.IDLE
	print("dodge ready")
	pass # Replace with function body.


func take_damage(damage,knockback_force,attack_position):
	knockback += damage
	velocity = (global_position - attack_position).normallized()*knockback_force
	pass

func _on_attacktimer_timeout() -> void:
	print("attack over")
	remove_child(instance)
	pass # Replace with function body.
 
