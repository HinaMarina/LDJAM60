class_name EnemyStateMachine extends Node2D


var current_state:EnemyState
var last_state:EnemyState
var machine_owner:Node

	
func set_state(new_state:EnemyState,override:bool=false):

	if (new_state != current_state || override):
		last_state = current_state
		#print(machine_owner, ' is setting ', new_state)
	
		current_state = new_state
		current_state.initialize()
		current_state.enter()
	
			
