extends PlayerState


func enter():
	PlayerStatsManager.player_died.emit(core.player_core.body.current_tapes)
	if core.player_core.xInput>=0:
		core.player_core.animator.play("Death_Fall_E")
	else:
		core.player_core.animator.play("Death_Fall_W")
	await core.animator.animation_finished
	if core.player_core.xInput>=0:
		core.player_core.animator.play("Death_Cry_E")
	else:
		core.player_core.animator.play("Death_Cry_W")
	await core.animator.animation_finished
	core.body.get_parent().queue_free()
