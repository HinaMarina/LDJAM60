class_name EnemyCore extends EnemyStateCore


@onready var main_machine:EnemyStateMachine

@export var Enemy_Search:EnemyState
@export var Walk:EnemyState
@export var AirControl:EnemyState
@export var Death:EnemyState

var direction_x:float
var direction_y:float


func _ready():

	main_machine = EnemyStateMachine.new()
	main_machine.machine_owner = self
	set_instances()
	
	main_machine.set_state(Enemy_Search)
	
func select_state():
	if AirControl.is_active() && AirControl.is_complete:
		main_machine.set_state(Walk)
		
	if Walk.is_active() && !body.is_on_floor():
		main_machine.set_state(AirControl)
		
	if Enemy_Search.is_active() && Enemy_Search.is_complete:
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


func update_player_direction():
	direction_x = -EnemyManager.current_scene.Current_Player.body.global_position.direction_to(body.global_position).x
	direction_y = -EnemyManager.current_scene.Current_Player.body.global_position.direction_to(body.global_position).y

func die():
	main_machine.set_state(Death)
