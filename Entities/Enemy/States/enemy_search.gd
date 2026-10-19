extends EnemyState

func enter():
	super()
	core.enemy_core.animator.play("EnemySearch")
	await get_tree().create_timer(2).timeout
	complete()
