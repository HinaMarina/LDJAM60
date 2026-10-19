class_name VHSTape extends Node2D

@export var animation:AnimatedSprite2D

@export var initial_position:Vector2
var playerbody : PlayerBody
var body_to_follow:Node2D
@export var Area:Area2D
var Tape_Kind:Array[String]
var is_following:bool=false

func _ready() -> void:
	initial_position = self.global_position
	var number= randi_range(0,3)
	Tape_Kind.append("Black")
	Tape_Kind.append("Brown")
	Tape_Kind.append("Green")
	Tape_Kind.append("Pink")
	#print(Tape_Kind[number])
	animation.play(Tape_Kind[number])

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerBody:
		is_following = true
		playerbody = body
		if !playerbody.current_tapes.is_empty():
			body_to_follow = playerbody.current_tapes[-1]
			
		else:
			body_to_follow = body
		playerbody.add_tape(self)
		Area.set_deferred('monitoring',false)

func monitoring():
	Area.set_deferred('monitoring',true)


func stop_following():
	is_following = false
	body_to_follow = null
	

func _process(delta: float) -> void:
	if !is_following:
		self.global_position = initial_position
	if body_to_follow != null:
		var direction = playerbody.maincore.last_xInput
		var multiplier:float
		var multiplierx:float
		if body_to_follow is VHSTape:
			multiplier = 0.0
			multiplierx = 1.5
			if playerbody.maincore.xInput != 0:
				multiplierx = 0
				
		else:
			multiplier = 1.0
			multiplierx = 1.0
		var point = sign(direction)*multiplierx*Vector2(12,0)-multiplier*Vector2(0,-8)
		
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self,'global_position',body_to_follow.global_position-point,0.2)
