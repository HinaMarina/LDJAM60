extends EnemyState
@export var Jump:EnemyState
@export var Fall:EnemyState

func enter():
	super()
	set_air_state()

func set_air_state():
	if Fall.is_active() && Fall.is_complete:
		complete()
		return
	if core.body.is_on_floor():
		_machine.set_state(Jump)
		return
	else:
		
		_machine.set_state(Fall)
		
	if Jump.is_active() && Jump.is_complete:
		_machine.set_state(Fall)
		return
	
		
		
func do(delta):
	super(delta)
	set_air_state()
