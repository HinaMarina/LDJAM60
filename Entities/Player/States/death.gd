extends PlayerState

@export var HurtSFX:AudioStream

func enter():
	SoundManager.play_sfx(HurtSFX)
	var current_tapes : Array[VHSTape]
	for each in core.player_core.body.current_tapes:
		current_tapes.append(each)
	core.player_core.body.current_tapes.clear()
	PlayerStatsManager.player_died.emit(current_tapes)
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
