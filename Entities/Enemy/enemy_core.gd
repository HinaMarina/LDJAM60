class_name EnemyCore extends EnemyStateCore


@onready var main_machine:EnemyStateMachine

@export var Enemy_Search:EnemyState
@export var Walk:EnemyState
@export var AirControl:EnemyState
@export var Death:EnemyState

@export var SearchTimer:Timer
@export var JumpDelayer:Timer
@export var JumpDirector1:RayCast2D
@export var JumpDirector2:RayCast2D



var can_jump:bool = true
var direction_x:float
var direction_y:float

var delayed_direction_x:float
var delayed_direction_y:float


func _ready():

	main_machine = EnemyStateMachine.new()
	main_machine.machine_owner = self
	set_instances()
	
	main_machine.set_state(Walk)
	SearchTimer.start(3)
	
func select_state():
	if delayed_direction_y<0 && Walk.is_active() && can_jump:
		Walk.complete()
		main_machine.set_state(AirControl)
		AirControl._machine.set_state(AirControl.Jump)
		can_jump = false
		JumpDelayer.start()
		
		return
		
	if AirControl.is_active() && AirControl.is_complete:
		main_machine.set_state(Walk)
		
	if Walk.is_active() && !body.is_on_floor():
		main_machine.set_state(AirControl)
		
	if Enemy_Search.is_active() && Enemy_Search.is_complete:
		SearchTimer.start(6)
		main_machine.set_state(Walk)
		
		
func _process(delta: float) -> void:
	#print(main_machine.current_state)
	if EnemyManager.current_scene.Current_Player != null:
		update_player_direction()
	
	select_state()
	if main_machine.current_state != null:
		main_machine.current_state.do(delta)
		
func _physics_process(delta: float) -> void:
	if main_machine.current_state != null:
		main_machine.current_state.physics_do(delta)
	if delayed_direction_x!=0:
		JumpDirector2.target_position.x = sign(delayed_direction_x)*abs(JumpDirector2.target_position.x)
		JumpDirector1.target_position.x = sign(delayed_direction_x)*abs(JumpDirector1.target_position.x)
func update_player_direction():
	direction_x = -EnemyManager.current_scene.Current_Player.body.global_position.direction_to(body.global_position).x
	direction_y = -EnemyManager.current_scene.Current_Player.body.global_position.direction_to(body.global_position).y

func die():
	#var index = EnemyManager.all_spawned_enemies.bsearch(self.get_parent().get_parent())
	main_machine.set_state(Death)


func _on_timer_timeout() -> void:
	if body.is_on_floor():
		main_machine.set_state(Enemy_Search)
	else:
		SearchTimer.start()


func _on_jump_delayer_timeout() -> void:
	if JumpDirector2.is_colliding() && !JumpDirector1.is_colliding():
		can_jump = true
	


func _on_direction_delayer_timeout() -> void:
	delayed_direction_x = direction_x
	delayed_direction_y = direction_y
