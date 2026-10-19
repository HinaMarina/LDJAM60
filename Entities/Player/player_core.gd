class_name PlayerCore extends PlayerStateCore
var is_holding_girl:bool = false
var current_girl_being_hold:String

@onready var main_machine:PlayerStateMachine


@export var Ground_Control:PlayerState
@export var Air_Control:PlayerState

@export var Warrior:PlayerState


var can_player_move:bool= true

var input_vector:Vector2
var last_xInput:float
var xInput:float
var yInput:float

var last_action:String
var double_tap_time_limit:float = 0.3
var double_tap_time:float




func _ready():

	PlayerStatsManager.Arcade_Stick_Catched.connect(on_arcade_stick_catched)
	input_vector = Vector2(0,1)
	main_machine = PlayerStateMachine.new()
	main_machine.machine_owner = self
	set_instances()
	
	#main_machine.set_state(Ground_Control)

	if body.is_on_floor():
		main_machine.set_state(Ground_Control)
	else:
		main_machine.set_state(Air_Control)
	
func select_state():
		
	if Warrior.is_active() && Warrior.is_complete:
	
		main_machine.set_state(Air_Control)
		Air_Control._machine.set_state(Air_Control.Fall)
		
		return
	
	if Ground_Control.is_active() && Ground_Control.is_complete:
		main_machine.set_state(Air_Control)
		return
	

	
	if Ground_Control.is_active():
		if Input.is_action_just_pressed("jump"):
			Ground_Control.complete()
			main_machine.set_state(Air_Control)
			return	
	
	
	
		
	if Air_Control.is_complete && Air_Control.is_active():
		main_machine.set_state(Ground_Control)
		


func updates_input_vector():
	#print(can_player_move)
	if !can_player_move:
		return
	
	xInput = Input.get_axis("ui_left","ui_right")
	yInput = Input.get_axis("ui_down","ui_up")
	
	if xInput!= 0:
		
		last_xInput = input_vector.x
		input_vector = Vector2(xInput,yInput)
		
		#player_gaze.target_position.x = 35*xInput
		


	
func _process(delta: float) -> void:
	#print(body.is_on_floor())
	updates_input_vector()
	select_state()
		
	if main_machine.current_state != null:
		main_machine.current_state.do(delta)
		
func _physics_process(delta: float) -> void:
	
	if main_machine.current_state != null:
		main_machine.current_state.physics_do(delta)

func is_inputting_jump():
	return Input.is_action_pressed("jump")
		


func pause_movement():
	can_player_move = false
	
func release_movement():
	can_player_move = true
	
func on_arcade_stick_catched():
	main_machine.set_state(Warrior)
