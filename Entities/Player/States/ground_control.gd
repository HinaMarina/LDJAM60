extends PlayerState

@export var Idle:PlayerState
@export var Run:PlayerState
#@export var On_Edge:PlayerState


var last_before_completing:PlayerState


func enter():
	super()

func _ready():
	super()
	
	await tree_is_set ## Everything after this will be processed after PlayerState tree is set
	

	
func select_state():
	
	if Idle.is_active() && core.player_core.xInput!=0:
		_machine.set_state(Run)
		return
	
			
	if Run.is_active() && !Run.is_complete:
		return
	if Run.is_active() && Run.is_complete:
		_machine.set_state(Idle)
		
	else:
		_machine.set_state(Idle)
	
	

func do(delta):
	#print(_machine.current_state)
	#print(all_transition_states)
	super(delta)
	select_state()
	if !core.body.is_on_floor():
		complete()

#func _unhandled_input(event: InputEvent) -> void:
	#pass
	

		
func complete():
	last_before_completing = _machine.current_state
	if !_machine.current_state == null:
		_machine.current_state = null
	super()
	
