class_name AutomaticDoor extends Node2D

@export var animator:AnimatedSprite2D

@export var Spawn_Anchor:Node2D

@export var Level_Enemy_Amount:=1
var current_scene:SceneLevel

func _ready():
	current_scene = get_parent() as SceneLevel
	animator.play("Idle")

func spawn_enemy():
	animator.play('Spawn')
	await animator.animation_finished
	EnemyManager.insert_enemy(Spawn_Anchor.global_position,current_scene)
	animator.play("Close")


func _on_timer_timeout() -> void:
	if EnemyManager.enemy_amount>=Level_Enemy_Amount:
		return
	spawn_enemy()
