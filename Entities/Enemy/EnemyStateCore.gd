class_name EnemyStateCore extends Node

@export var body:CharacterBody2D
@export var animator:EnemyAnimator
@export var enemy_core:EnemyCore
@export var enemy_gaze:RayCast2D

func set_instances():
	for each in self.get_children():
		if each is EnemyState:
			each.set_tree(self)
