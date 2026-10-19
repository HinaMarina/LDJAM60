extends PlayerState
@export var friction:= 25
@export var state_sprite:Sprite2D

#@export var no_blink_texture:Texture2D
#@export var blink_texture:Texture2D
#var blinked:bool = false

func enter():
	super()
	sets_animation_direction()

func do(delta):
	super(delta)
	
	
	
	

func physics_do(delta):
	super(delta)
	core.body.velocity = core.body.velocity.move_toward(Vector2.ZERO,friction)
	core.body.move_and_slide()


func sets_animation_direction():
	if core.player_core.input_vector.x>=0:
		state_sprite.flip_h = false
		core.animator.play("Idle_E")
	else:
		state_sprite.flip_h = true
		core.animator.play("Idle_W")
