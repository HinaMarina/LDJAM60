extends Node2D

var current_scene:int
var last_scene:int

@export var Game_Scenes : Array[PackedScene]

func set_scene(new_scene:int):
	if new_scene != current_scene:
		last_scene = current_scene
		current_scene = new_scene
		
func get_current_scene():
	return Game_Scenes[current_scene]
	
func get_last_scene():
	if last_scene != null:
		return Game_Scenes[last_scene]
	
	
func change_scene(scene_index):
	load_scene()
	await play_scene_transition()
	set_scene(scene_index)
	get_tree().change_scene_to_packed(Game_Scenes[scene_index])



func load_scene():
	pass
	
func play_scene_transition():
	pass
