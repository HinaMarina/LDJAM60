extends Node2D

@export var animator:AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play("Press_Start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_game"):
		PlayerStatsManager.set_first_stage()
