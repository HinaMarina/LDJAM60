extends Node2D

signal Arcade_Stick_Catched()
signal player_spawned()
signal player_died(vhs_array:Array[VHSTape])

var current_scene:SceneLevel
var stage_cleared:bool = false

@export var Fanfarre:AudioStream
@export var Game_Over:AudioStream
@export var Level_Song:AudioStream

@export var life_amount_icon:TextureRect

@export var vhs_tape_scene:PackedScene
@export var state_clear_animator:AnimationPlayer

@onready var Credits:int=0
@onready var PlayerPoints:int = 0
@onready var Life_Amount:int = 3

const initial_life_amount:= 3
const initial_scene_index:= 0

@onready var current_scene_index:int=0


@export var PlayerScene:PackedScene
@export var credit_label:Label
@export var points_label:Label

@export var All_Stages: Array[PackedScene]
@export var Start_Menu_Packed:PackedScene

func Spawn_Player(spawn_target:Vector2,Scene:SceneLevel):
	life_amount_icon.visible = true
	stage_cleared = false
	current_scene = Scene
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
	if stage_cleared:
		if Input.is_action_just_pressed('start_game'):
			SoundManager.play_bgm(Level_Song)
			state_clear_animator.play_backwards("Stage_Clear")
			await state_clear_animator.animation_finished
			get_tree().change_scene_to_packed(All_Stages[current_scene_index+1])
			current_scene_index+=1
			stage_cleared = false
			await get_tree().create_timer(0.2).timeout
			EnemyManager.enemy_amount = 0
			current_scene = get_tree().current_scene as SceneLevel
			current_scene.Level_Elevator.spawn()
	if Input.is_action_just_pressed("insert_credit"):
		insert_credit()
		
func add_points(amount:int):
	PlayerPoints+=amount
	points_label.text = str(PlayerPoints)


func _ready() -> void:
	player_died.connect(on_player_death)
	life_amount_icon.size.x = Life_Amount*life_amount_icon.get_minimum_size().x
	life_amount_icon.visible = false
	
func on_player_death(tapes:Array[VHSTape]):
	
	Life_Amount -=1
	life_amount_icon.size.x = Life_Amount*life_amount_icon.get_minimum_size().x

	if Life_Amount <= 0:
		life_amount_icon.visible = false
		state_clear_animator.play("Game_Over")
		SoundManager.play_bgm(Game_Over)
		await state_clear_animator.animation_finished
		await get_tree().create_timer(1.7).timeout
		get_tree().change_scene_to_packed(Start_Menu_Packed)
		#EnemyManager.clear_all_enemies()
		state_clear_animator.play_backwards("Game_Over")
		EnemyManager.enemy_amount = 0
		return
	
	else:
		current_scene.Level_Elevator.spawn()
		
	var all_initial_locations :Array[Vector2]
	for each_tape in tapes:
		all_initial_locations.append(each_tape.initial_position)
		each_tape.queue_free()
	#print(all_initial_locations)
	for each in all_initial_locations:
		var new_tape = vhs_tape_scene.instantiate() as VHSTape
		new_tape.global_position = each
		if current_scene == null:
			current_scene = get_tree().current_scene
			
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
		
func _process(delta: float) -> void:
	#print(EnemyManager.enemy_amount)
	if current_scene != null:
		if current_scene.CRT_Amount<=0 && !stage_cleared:
			EnemyManager.clear_all_enemies()
			#current_scene.Current_Player.body.maincore.pause_movement()
			stage_cleared = true
			if current_scene_index+1 >=6:
				state_clear_animator.play("THANKS")
				return
			SoundManager.play_bgm(Fanfarre)
			state_clear_animator.play("Stage_Clear")
			await state_clear_animator.animation_finished
			state_clear_animator.play('Press_Start')
			pass
			
func next_stage():
	pass

func set_first_stage():
	EnemyManager.enemy_amount = 0
	stage_cleared = false
	Life_Amount = initial_life_amount
	life_amount_icon.size.x = Life_Amount*life_amount_icon.get_minimum_size().x
	current_scene_index = initial_scene_index
	SoundManager.play_bgm(Level_Song)
	get_tree().change_scene_to_packed(PlayerStatsManager.All_Stages[0])
	await get_tree().create_timer(0.1).timeout
	current_scene = get_tree().current_scene as SceneLevel
	current_scene.Level_Elevator.spawn()

func add_life():
	
	Life_Amount +=1
	life_amount_icon.size.x = Life_Amount*life_amount_icon.get_minimum_size().x
