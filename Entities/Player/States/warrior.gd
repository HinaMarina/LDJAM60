extends PlayerState

@export var Transformation:PlayerState
@export var Cycle:PlayerState

func enter():
	super()
	_machine.set_state(Transformation)
	await Transformation.finished_transformation
	_machine.set_state(Cycle)
	
	
	
func sets_animation():
	if core.player_core.xInput>=0:
		core.animator.play("Warrior_Cycle_E")
	else:
		core.animator.play("Warrior_Cycle_W")		
		

func do(delta):
	super(delta)
	if Cycle.is_active() && Cycle.is_complete:
		complete()
