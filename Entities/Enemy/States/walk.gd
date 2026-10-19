extends EnemyState
@export var max_speed:float = 80.0
@export var acceleration:float = 10.0
	
	
func physics_do(delta):
	super(delta)
	core.body.velocity = core.body.velocity.move_toward(Vector2(sign(core.enemy_core.delayed_direction_x),0)*max_speed,acceleration*80*delta)
	core.body.move_and_slide()
#
func do(delta):
	super(delta)
	sets_animation()

func sets_animation():
	if core.enemy_core.direction_x>=0:
		core.animator.play("Walk_E")
	else:
		core.animator.play("Walk_W")
