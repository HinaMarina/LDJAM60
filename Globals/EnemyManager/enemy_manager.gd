extends Node2D

var current_scene:SceneLevel
@export var enemy_scene:PackedScene
var enemy_amount:int=0
var all_spawned_enemies:Array[EnemyNode]

func insert_enemy(target:Vector2,scene:SceneLevel):
	if current_scene!= scene:
		current_scene = scene
		
	var enemy = enemy_scene.instantiate()
	scene.Enemy_Layer.add_child(enemy)
	all_spawned_enemies.append(enemy)
	enemy_amount+=1
	enemy.global_position = target
	#if PlayerStatsManager.stage_cleared:
		#enemy.die()


func clear_all_enemies():
	#print(all_spawned_enemies)
	for each in all_spawned_enemies:
		if each != null:
			each.Core.die()
	all_spawned_enemies.clear()
	#enemy_amount = 0

func _process(delta: float) -> void:
	#print(enemy_amount)
	if PlayerStatsManager.stage_cleared && !all_spawned_enemies.is_empty():
		for each in all_spawned_enemies:
			each.Core.die()
