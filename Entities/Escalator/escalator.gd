extends Node2D

@onready var bodys_to_move:Array[CharacterBody2D]
@export var pointing_right:bool=true
var drag_force := 70.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if !pointing_right:
		drag_force = -abs(drag_force)
	else:
		drag_force = 70


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(bodys_to_move)
	if !bodys_to_move.is_empty():
		
		for each in bodys_to_move:
			if each.is_on_floor():
				if each is PlayerBody:
					var core = each.maincore
					var xInput = core.xInput
					each.velocity = each.velocity.move_toward(Vector2(xInput*60+drag_force,each.velocity.y),25)
					
				if each is EnemyBody:
					var core = each.enemycore
					var xInput = core.direction_x
					each.velocity =  each.velocity.move_toward(Vector2(xInput*60+drag_force,each.velocity.y),25)

				each.move_and_slide()


func _on_drag_area_body_entered(body: Node2D) -> void:
	#print(body)
	if body is PlayerBody || body is EnemyBody:
		bodys_to_move.append(body)


func _on_drag_area_body_exited(body: Node2D) -> void:
	if body is PlayerBody || body is EnemyBody:
		bodys_to_move.erase(body)
