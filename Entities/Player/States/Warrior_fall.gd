extends PlayerState

@export var jump_height:float = 48.0
@export var fall_time:float = 0.4

@onready var fall_gravity:float = (-1)*(-2*jump_height)/(fall_time*fall_time)
@export var max_speed_on_air:int =75
@export var min_speed_on_air:int = 50
const speed_on_air:= 75


var current_horizontal_velocity:int
@export var max_fall_speed:int = 450
@export var state_sprite:Sprite2D


func initialize():
	super()
	state_sprite.flip_h = core.player_core.input_vector.x < 0
	#state_sprite.frame = 0
	#max_speed_on_air = 85

func get_gravity():
	return fall_gravity

func enter():
	current_horizontal_velocity = abs(int(core.body.velocity.x))
	max_speed_on_air = max(current_horizontal_velocity,speed_on_air)
	super()
	if core.body.is_on_floor():
		complete()
	
func physics_do(delta):
	
	super(delta)
	core.body.velocity.y += get_gravity()*delta
	core.body.velocity.y = clamp(core.body.velocity.y,-max_fall_speed,max_fall_speed)
	var new_speed_on_air = sign(core.player_core.xInput)*max(min_speed_on_air,abs(core.player_core.xInput*max_speed_on_air))
	if core.player_core.xInput == 0:
		new_speed_on_air = sign(core.player_core.last_xInput)*max(min_speed_on_air,abs(core.player_core.last_xInput*max_speed_on_air))
	core.body.velocity.x = new_speed_on_air*60*delta
	core.body.move_and_slide()
	
func do(delta):
	if core.body.is_on_floor():
		complete()
	super(delta)
	#sets_animation()
	
#func sets_animation():
	#if core.player_core.input_vector.x > 0:
		#state_sprite.flip_h = false
		#core.animator.play("Warrior_Cycle_E")
	#else:
		#state_sprite.flip_h = true
		#core.animator.play("Warrior_Cycle_W")
