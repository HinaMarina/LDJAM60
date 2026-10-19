extends Node2D

var current_scene:SceneLevel
@export var enemy_scene:PackedScene
var enemy_amount:int=0

func insert_enemy(target:Vector2,scene:SceneLevel):
	if current_scene!= scene:
		current_scene = scene
		
	var enemy = enemy_scene.instantiate()
	scene.Enemy_Layer.add_child(enemy)
	enemy_amount+=1
	enemy.global_position = target
