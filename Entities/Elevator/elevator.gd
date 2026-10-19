class_name Elevator extends Node2D

@export var Base_Sprites:AnimatedSprite2D

@export var Spawn_sprite:Sprite2D
@export var _animator:AnimationPlayer
@export var Spawn_Point:Node2D
@export var Current_Scene:SceneLevel


func _ready():
	Base_Sprites.play("OFF")
	Spawn_sprite.visible = false


func spawn():
	Spawn_sprite.visible = true
	_animator.play("Player_Spawn")
	await _animator.animation_finished
	PlayerStatsManager.Spawn_Player(Spawn_Point.global_position,Current_Scene)
	#await PlayerStatsManager.player_spawned
	Spawn_sprite.visible=false
	Base_Sprites.play_backwards('Opening')
	await Base_Sprites.animation_finished
	Base_Sprites.play("OFF")
