extends PlayerState


func enter():
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
