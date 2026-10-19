extends PlayerState

@export var GroundControl:PlayerState
@export var AirControl:PlayerState
@export var state_sprite:Sprite2D

func enter():
	super()
	if core.body.is_on_floor():
		_machine.set_state(GroundControl)
	else:
		_machine.set_state(AirControl)


func do(delta):
	super(delta)
	select_state()
	sets_animation()
	
	if lambda_time()>=4:
		complete()

func select_state():
		
	if GroundControl.is_active() && GroundControl.is_complete:
		if GroundControl.last_before_completing == GroundControl.Run:
			AirControl.was_running  = true
		else:
			AirControl.was_running = false
		_machine.set_state(AirControl)
		return
	
	if GroundControl.is_active() && !core.body.is_on_floor():
		GroundControl.complete()
		_machine.set_state(AirControl)
		return
	
	if GroundControl.is_active():
		if Input.is_action_just_pressed("jump"):
			GroundControl.complete()
			_machine.set_state(AirControl)
			return	
	
		
	if AirControl.is_complete && AirControl.is_active():
		_machine.set_state(GroundControl)

func sets_animation():
	if core.player_core.input_vector.x >= 0:
		state_sprite.flip_h = false
		core.animator.play("Warrior_Cycle_E")
	else:
		state_sprite.flip_h = true
		core.animator.play("Warrior_Cycle_W")
