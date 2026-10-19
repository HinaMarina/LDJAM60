extends Node2D

signal Arcade_Stick_Catched()
signal player_spawned()
signal player_died(vhs_array:Array[VHSTape])

var current_scene:SceneLevel

@export var vhs_tape_scene:PackedScene

@onready var Credits:int=0
@onready var PlayerPoints:int = 0
@onready var Life_Amount:int = 1



@export var PlayerScene:PackedScene
@export var credit_label:Label
@export var points_label:Label


func Spawn_Player(spawn_target:Vector2,Scene:SceneLevel):
	current_scene = Scene
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


func _ready() -> void:
	player_died.connect(on_player_death)
	
func on_player_death(tapes:Array[VHSTape]):
	Life_Amount -=1
	
	if Life_Amount <= 0:
		pass
		
		
	var all_initial_locations :Array[Vector2]
	for each_tape in tapes:
		all_initial_locations.append(each_tape.initial_position)
		each_tape.queue_free()
	for each in all_initial_locations:
		var new_tape = vhs_tape_scene.instantiate() as VHSTape
		new_tape.global_position = each
		current_scene.Tape_Level.call_deferred('add_child',new_tape)

	#for each in tapes:
		#each.stop_following()
		#print(each.initial_position)
		#each.global_position = each.initial_position
		##if each != null:
			##each.stop_following()
	#if tapes.is_empty():
		#return
	#else:
		#for tape in tapes:
			#tape.global_position = tape.initial_position
			#tape.monitoring()
			#print('here')
		#tapes.clear()
	
