class_name PlayerBody extends CharacterBody2D

@export var maincore:PlayerCore



@onready var current_tapes:Array[VHSTape]

func add_tape(tape:VHSTape):
	current_tapes.append(tape)
	
func insert_tape():
	if current_tapes.is_empty():
		return
	if current_tapes[-1] != null:	
		current_tapes[-1].queue_free()
	current_tapes.remove_at(-1)
