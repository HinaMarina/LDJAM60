extends PlayerState



@export var Jump:PlayerState
@export var Fall:PlayerState


@export var coyote_time :=0.1
@export var jump_buffer:= 0.1
@export var jump_pressed:float = 0.0
var already_jumped:bool = true

var was_running:bool


func _ready():
	super()
	


func enter():
	
	#if was_running:
		#Jump.max_speed_on_air = Jump.speed_on_air + 20
		#Fall.max_speed_on_air = Fall.speed_on_air + 20
	#else:
	Jump.max_speed_on_air = Jump.speed_on_air
	Fall.max_speed_on_air = Fall.speed_on_air
		
	super()
	already_jumped = false
	set_air_state()
	
	
func initialize():
	super()
	#
		
func set_air_state():
	if already_jumped:
		return
	if core.body.is_on_floor():
		_machine.set_state(Jump)
		already_jumped = true
	else:
		_machine.set_state(Fall)
	#if core.body.is_on_floor():
		#_machine.set_state(Jump)
		#already_jumped = true

		
	#if Input.is_action_just_pressed("jump") && core.body.is_on_floor():
		#if !already_jumped:
			#
			#_machine.set_state(Jump)
			#
		#already_jumped = true
		#
	#elif !core.body.is_on_floor() && _machine.current_state!= Jump:
		#_machine.set_state(Fall)
		
func coyote_time_checker():
	if !Fall.is_active():
		return
	if lambda_time() < coyote_time && Input.is_action_just_pressed("jump") && !already_jumped:
		_machine.set_state(Jump)
		already_jumped = true

func jump_buffer_checker():
	
	if Input.is_action_just_pressed("jump"):
		jump_pressed = jump_buffer ## Resets the value when jump pressed when falling
		
	if core.body.is_on_floor() && jump_pressed > 0 && core.player_core.is_inputting_jump(): 
		## verifies if is grounded before jump_buffer amount
	

		_machine.set_state(Jump)
		return
			
	elif core.body.is_on_floor():
		complete()

func do(delta):
	#if Fall.is_active():
		#already_jumped = true
	#print("my machine is set to " + _machine.current_state.name)
	#if Jump.is_active():
		#Fall.is_complete = true
	
	jump_pressed -= delta #decreases the value in the amount of time since pressed

	
	


		
			
	if Jump.is_active() && Jump.is_complete:	
		_machine.set_state(Fall)
	
	if Fall.is_active():
		coyote_time_checker()
		jump_buffer_checker()
	#
	super(delta)
	

func complete():
	super()
	#clear_machine()
