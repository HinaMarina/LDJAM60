extends PlayerState

@export var jump_height:float = 52
@export var peak_time:float = 0.4

@onready var jump_velocity:float =(-1)*(2*jump_height)/peak_time
@onready var jump_gravity:float = (-1)*(-2*jump_height)/(peak_time*peak_time)

@export var max_speed_on_air:int =75
@export var min_speed_on_air:int = 50
const speed_on_air:= 75
var current_horizontal_velocity:int
@export var state_sprite:Sprite2D

var difference_waiting:bool = false
@onready var min_height = jump_height/2
@onready var full_time = peak_time
signal can_be_override

func initialize():
	super()
	
	state_sprite.frame = 0
	core.body.velocity.y = 0
	
	difference_waiting = false
	jump_height = min_height*3
	peak_time = full_time

func can_be_override_checker():
	return !lambda_time()<full_time/3
	
func enter():
	current_horizontal_velocity = abs(int(core.body.velocity.x))
	max_speed_on_air = max(current_horizontal_velocity,speed_on_air)
	super()
	jump()
	is_jump_already_released()




func get_gravity():
	return jump_gravity

	
func do(delta):
	if lambda_time() > full_time/3:
		can_be_override.emit()
	if lambda_time()< full_time/1.5:
		is_jump_already_released()

	super(delta)
	if lambda_time()>peak_time && is_active():
		core.body.velocity.y = 0
		complete()

func is_jump_already_released():
	if !Input.is_action_pressed('jump'):
		if !difference_waiting:
			peak_time = full_time/3
			jump_height = min_height/3
			difference_waiting = true

			
func jump():
	core.body.velocity.y = jump_velocity
	#sets_animation()

func physics_do(delta):
	super(delta)
	#core.body.velocity = core.body.velocity.move_toward(Vector2(core.body.velocity.x,core.player_core.xInput*max_speed_on_air),35)
	core.body.velocity.y += get_gravity()*delta
	var new_speed_on_air = sign(core.player_core.xInput)*max(min_speed_on_air,abs(core.player_core.xInput*max_speed_on_air))
	if core.player_core.xInput == 0:
		new_speed_on_air = sign(core.player_core.last_xInput)*max(min_speed_on_air,abs(core.player_core.last_xInput*max_speed_on_air))
	core.body.velocity.x = new_speed_on_air*60*delta
	core.body.move_and_slide()
	
		
#func sets_animation():
	#if core.player_core.input_vector.x >= 0:
		#state_sprite.flip_h = false
		#core.animator.play("Warrior_Cycle_E")
	#else:
		#state_sprite.flip_h = true
		#core.animator.play("Warrior_Cycle_W")
