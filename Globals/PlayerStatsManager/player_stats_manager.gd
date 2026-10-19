extends Node2D

signal Arcade_Stick_Catched()
signal player_spawned()

@onready var Credits:int=0

@export var PlayerScene:PackedScene



func Spawn_Player(spawn_target:Vector2,Scene:SceneLevel):
	var Player = PlayerScene.instantiate()
	Scene.insert_player(Player)
	var body = Player.get_child(0) as PlayerBody
	body.global_position = spawn_target
	player_spawned.emit()


func insert_credit():
	Credits+=1

func use_credit():
	Credits-=1

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("insert_credit"):
		insert_credit()
