class_name SceneLevel extends Node2D


@export var Player_Layer:Node2D
@export var Enemy_Layer:Node2D
@export var Level_Elevator:Elevator
@export var Tape_Level:Node2D

@export var CRT_Amount:int=1


#@export var rect_map:TileMapLayer
#@export var platform_tilemap:TileMapLayer
#@onready var pathfiding_grid := AStarGrid2D.new()

var path_line:=Line2D.new()


var Current_Player:PlayerNode


func _ready() -> void:
	pass
	#update_pathfiding()

func insert_player(Player:PlayerNode):
	if Current_Player == null:
		Player_Layer.add_child(Player)
		Current_Player = Player

func remove_player():
	Current_Player = null

func start_player():
	if PlayerStatsManager.Credits > 0:
		if Current_Player == null:
			if Level_Elevator.Spawn_sprite.visible == true:
				return
			PlayerStatsManager.use_credit()
			Level_Elevator.spawn()
	else:
		return
		

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_game"):
		start_player()



#func update_pathfiding():
	#pathfiding_grid.region = rect_map.get_used_rect()
	#pathfiding_grid.cell_size = Vector2(16,16) #tilesize
	#pathfiding_grid.offset = Vector2(pathfiding_grid.cell_size.x/2,2)
	#pathfiding_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	#pathfiding_grid.update()
	#for each_cell in platform_tilemap.get_used_cells():
		#pathfiding_grid.set_point_solid(each_cell,true)
		#
#func calculate_path(from:Vector2,target:Vector2):
	##print(from, ' ', target)
	#var origin = platform_tilemap.local_to_map(to_local(from))
	#var destination = platform_tilemap.local_to_map(to_local(target))
	##print(origin, ' e', destination)
	#var path = pathfiding_grid.get_point_path(origin,destination)
	#var new_path:Array[Vector2]
	
	#for each in path:
		#new_path.append(to_global(each))
	#print(new_path)
	#draw_path_line(new_path)
	#return new_path
#
#
#func draw_path_line(path:Array[Vector2]):
	#path_line.clear_points()
	#for each in path:
		#path_line.add_point(each)
		#await get_tree().create_timer(0.02).timeout
		#continue
	#path_line.visible = true
	#Player_Layer.add_child(path_line)
