extends Node

@export var CRTFilter:CanvasLayer
@export var Blur:CanvasLayer

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("CRT_ON"):
		CRTFilter.visible = !CRTFilter.visible
		Blur.visible = !Blur.visible

#func _ready() -> void:
	#CRTFilter.visible = false
	#Blur.visible = false
