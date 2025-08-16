extends CharacterBody2D


var primary:attackClass


var SPEED = 300.0
var JUMP_VELOCITY = -500.0
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


#set animations
@onready var Anim = $Node2D2/AnimationPlayer

#player States
enum States {IDLE,RUNNING,INAIR,DAMAGED,CROUCH,DODGE,LEDGE,STUNNED}
enum lookat {RIGHT,LEFT}
enum moveInput {RIGHT,LEFT,UP,DOWN,NONE}
enum action {IDLE, ATTACK, SPECIAL, MOVING,DODGE}

var look = lookat.RIGHT
var state = States.IDLE
var currAction = action.IDLE
var DInput = moveInput.NONE




func _physics_process(delta: float) -> void:
	if currAction == action.IDLE or state == States.IDLE:
		Anim.play("Idle")
	elif currAction == action.MOVING:
		Anim.play("Moving")
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		state = States.INAIR
	else:
		state = States.IDLE
	
	# ===============================Start of inputs=======================================
	if Input.is_action_pressed("ui_down"):
		if is_on_floor():
			state = States.CROUCH
		DInput = moveInput.DOWN
	if Input.is_action_just_released("ui_down"):
		state = States.IDLE
		DInput = moveInput.NONE
		
	if Input.is_action_pressed("ui_left"):
		DInput = moveInput.LEFT
	if Input.is_action_just_released("ui_left"):
		DInput = moveInput.NONE
		
	if Input.is_action_pressed("ui_right"):
		DInput = moveInput.RIGHT
	if Input.is_action_just_released("ui_right"):
		DInput = moveInput.NONE
	
	if Input.is_action_pressed("ui_up"):
		DInput = moveInput.UP
	if Input.is_action_just_released("ui_up"):
		DInput = moveInput.NONE
	
	if Input.is_action_just_pressed("Attack_control"):
		currAction = action.ATTACK
		atk()
	
	if Input.is_action_just_pressed("Special_Attack_control"):
		currAction = action.SPECIAL
		Satk()
		
	if Input.is_action_just_pressed("dodge"):
		currAction = action.DODGE
		state = States.DODGE
		dodge()
		
	
	#=========================================end of inputs========================================
	
	
	
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
		
	
	
	
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		state = States.RUNNING
		if Input.is_action_pressed("ui_left"):
			currAction = action.MOVING
			look = lookat.LEFT
			DInput = moveInput.LEFT
		if Input.is_action_pressed("ui_right"):
			currAction = action.MOVING
			look = lookat.RIGHT
			DInput = moveInput.RIGHT
			
		velocity.x = direction * SPEED
	else:
		if Input.is_action_just_released("ui_left") or  Input.is_action_just_released("ui_right") :
			state = States.IDLE
			DInput = moveInput.NONE
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#=======================================================================
	
func atk ():
	#TODO: TRY TO FIND A WAY FOR PLAYERS TO HAVE BUTTON COMBOS
	if state == States.IDLE or state == States.CROUCH:
		neutral()
	elif state == States.INAIR:
		if DInput == moveInput.DOWN:
			downAir()
		else:
			nAir()
	else:
		print("what the fuck")
			
func Satk():
	if DInput == moveInput.DOWN:
		downSpecial()
	elif DInput == moveInput.NONE:
		Special()
	elif DInput == moveInput.UP:
		upSpecial()
	elif DInput == moveInput.RIGHT or DInput == moveInput.LEFT:
		sideSpecial()
		
#=================Attack functions====================

func neutral():
	print("neutral")

func nAir():
	print("nAir")

func downAir():
	print("dAir")

func Special():
	print("Special")

func upSpecial():
	print("USpecial")

func downSpecial():
	print("DSpecial")
	
func sideSpecial():
	print("SSpecial")
	
#=====================================================

func jump():
	if jump_Toggle:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

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
	velocity = (global_position - attack_position)*knockback_force
	print(velocity)
	pass


 
