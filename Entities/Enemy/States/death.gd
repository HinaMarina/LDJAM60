extends EnemyState

@export var DeathSFX:AudioStream

func enter():
	super()
	core.enemy_core.animator.play('Death')
	#EnemyManager.all_spawned_enemies.erase(self.get_parent().get_parent())
	await core.enemy_core.animator.animation_finished
	EnemyManager.enemy_amount -=1
	core.enemy_core.get_parent().get_parent().queue_free()
