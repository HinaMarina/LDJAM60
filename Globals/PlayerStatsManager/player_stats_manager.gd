extends Node2D

signal Arcade_Stick_Catched()
signal player_spawned()

@onready var Credits:int=0
@onready var PlayerPoints:int = 0

@export var PlayerScene:PackedScene
@export var credit_label:Label
@export var points_label:Label


func Spawn_Player(spawn_target:Vector2,Scene:SceneLevel):
	var Player = PlayerScene.instantiate()
	Scene.insert_player(Player)
	var body = Player.get_child(0) as PlayerBody
	body.global_position = spawn_target
	player_spawned.emit()


func insert_credit():
	Credits+=1
	credit_label.text = str(Credits)

func use_credit():
	Credits-=1
	credit_label.text = str(Credits)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("insert_credit"):
		insert_credit()
		
func add_points(amount:int):
	PlayerPoints+=amount
	points_label.text = str(PlayerPoints)
