extends EnemyState

var path
signal _finishing_moving

func enter():
	var vector2:Vector2
	if EnemyManager.current_scene.Current_Player != null:
		vector2 = EnemyManager.current_scene.Current_Player.body.global_position
	else:
		complete()
	super()
	#search_player(vector2)
	core.enemy_core.animator.play("EnemySearch")
	await get_tree().create_timer(3).timeout
	#await  _finishing_moving
	core.body.global_position = vector2 
	complete()

func search_player(vector2:Vector2):
	if EnemyManager.current_scene.Current_Player == null:
		return
	path = EnemyManager.current_scene.calculate_path(core.body.global_position,vector2)
	

func physics_do(delta):
	if path != null:
		for each in path:
			core.body.global_position = each
			await get_tree().create_timer(0.08).timeout
			continue
		_finishing_moving.emit()
	
