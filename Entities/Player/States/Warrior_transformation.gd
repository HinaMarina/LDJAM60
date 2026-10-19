extends PlayerState

signal finished_transformation()

func enter():
	if core.player_core.xInput>=0:
		core.animator.play("Warrior_Transformation_E")
	else:
		core.animator.play("Warrior_Transformation_W")
	await core.animator.animation_finished
	finished_transformation.emit()
