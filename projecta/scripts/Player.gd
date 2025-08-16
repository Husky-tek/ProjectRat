extends CharacterBody2D

var SPEED = 300.0
var JUMP_VELOCITY = -500.0
var jump_count = 0
var jump_Toggle = true


#================CharacterStates================
enum States {IDLE,RUNNING,INAIR,DAMAGED,CROUCH,DODGE,LEDGE}
enum lookat {RIGHT,LEFT}
enum moveInput {RIGHT,LEFT,UP,DOWN,NONE}
enum action {IDLE, ATTACK, SPECIAL, MOVING, DODGING}

var look = lookat.RIGHT
var state = States.IDLE
var currAction = action.IDLE
var DInput = moveInput.NONE


func _physics_process(delta: float) -> void:
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
	
	#=========================================end of inputs========================================
	
	if Input.is_action_just_pressed("Attack_control"):
		currAction = action.ATTACK
	
	if Input.is_action_just_pressed("Special_Attack_control"):
		print("special")
	
	if Input.is_action_just_pressed("dodge"):
		print("dodge")
		
	
	if Input.is_action_pressed("ui_down") and is_on_floor():
		state = States.CROUCH
		
	if jump_count ==  1:
		jump_Toggle = false

	#add limits to jumping
	if Input.is_action_just_pressed("ui_accept"):
		print("jump")
		

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
