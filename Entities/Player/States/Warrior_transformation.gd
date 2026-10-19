extends PlayerState

signal finished_transformation()
@export var WarriorFanfarre:AudioStream

func enter():
	SoundManager.play_bgm(WarriorFanfarre)
	if core.player_core.xInput>=0:
		core.animator.play("Warrior_Transformation_E")
	else:
		core.animator.play("Warrior_Transformation_W")
	await core.animator.animation_finished
	finished_transformation.emit()
