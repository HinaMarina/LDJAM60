extends PlayerState

@export var Run:PlayerState

var last_before_completing:PlayerState


func enter():
	super()

func _ready():
	super()
	
	await tree_is_set ## Everything after this will be processed after PlayerState tree is set
	

	
func select_state():

	_machine.set_state(Run)
	

func do(delta):
	super(delta)
	select_state()
	if !core.body.is_on_floor():
		complete()


	

		
func complete():
	last_before_completing = _machine.current_state
	if !_machine.current_state == null:
		_machine.current_state = null
	super()
	
