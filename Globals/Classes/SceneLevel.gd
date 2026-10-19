class_name SceneLevel extends Node2D


@export var Player_Layer:Node2D
@export var Level_Elevator:Elevator

var Current_Player:PlayerNode


func insert_player(Player:PlayerNode):
	if Current_Player == null:
		Player_Layer.add_child(Player)
		Current_Player = Player

func remove_player():
	Current_Player = null

func start_player():
	if PlayerStatsManager.Credits > 0:
		if Current_Player == null:
			PlayerStatsManager.use_credit()
			Level_Elevator.spawn()
	else:
		return
		

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_game"):
		start_player()
