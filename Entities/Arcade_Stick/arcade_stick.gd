extends Node2D

@export var area:Area2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerBody:
		PlayerStatsManager.Arcade_Stick_Catched.emit()
		queue_free()
	else:
		return
