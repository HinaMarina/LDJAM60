extends PlayerState

@export var max_speed:=125.0
@export var acceleration:=10.0
@export var state_sprite:Sprite2D

func enter():
	super()
	
#func sets_animation():
	#if core.player_core.input_vector.x >= 0:
		#state_sprite.flip_h = false
		#core.animator.play("Warrior_Cycle_E")
	#else:
		#state_sprite.flip_h = true
		#core.animator.play("Warrior_Cycle_W")

func do(delta):
	super(delta)
	#sets_animation()
	if core.player_core.xInput==0:
		complete()

func physics_do(delta):
	super(delta)
	core.body.velocity = core.body.velocity.move_toward(Vector2(core.player_core.input_vector.x,0)*max_speed,acceleration*80*delta)
	core.body.move_and_slide()
#


func complete():
	#core.player_core.pause_movement()
	#play_stop_transition()
	#await core.animator.transition_finished
	#core.player_core.release_movement()
	super()
