class_name CRT extends Node2D

@export var already_on:bool
@export var ON_SFX:AudioStream


@export var area:Area2D
var can_insert:bool=false
var player:PlayerBody
@export var Screen_Anchor:Node2D

@export var _animator:AnimationPlayer
@export var _screen_animator:AnimationPlayer
@onready var is_on:bool=false

@export var ON_Sprite:Sprite2D
@export var Image_Sprite:Sprite2D

@export var ScreenSprite:Sprite2D

@export var CRT_ON_Textures:Array[Texture2D]
@export var CRT_Image_Textures:Array[Texture2D]

@export var Model:int= 0
#0 = Black Trinitron, 1= GraySony, 2=Kitty, 3=Pikachu,4=SonyPVM

func _ready() -> void:
	if already_on:
		turn_on()
		set_model()
		return
	_animator.play('OFF')
	ON_Sprite.visible = true
	ScreenSprite.visible = false
	set_model()
	

func turn_on():
	if !already_on:
		PlayerStatsManager.current_scene.CRT_Amount -=1
	
	
	SoundManager.play_sfx(ON_SFX)
	area.set_deferred('monitoring',false)
	is_on = true
	_animator.play('ON')
	await _animator.animation_finished
	ON_Sprite.visible = false
	Image_Sprite.visible = true
	ScreenSprite.visible = true
	_screen_animator.play("Shake")
	ScreenSprite.frame = randi_range(0,6)
	_animator.play("Image")
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerBody:
		player = body
		if !body.current_tapes.is_empty():
			can_insert = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is PlayerBody:
		player = null
		can_insert = false

func _unhandled_input(event: InputEvent) -> void:
	if !can_insert:
		return
	if Input.is_action_just_pressed("insert_vhs"):
		player.insert_tape()
		turn_on()
		
func set_model():
	Image_Sprite.texture = CRT_Image_Textures[Model]
	ON_Sprite.texture = CRT_ON_Textures[Model]
	if Model == 0:
		Screen_Anchor.position = Vector2(0,-1)
	elif Model == 1:
		Screen_Anchor.position = Vector2(2,-2)
	elif Model == 2 || Model == 3:
		Screen_Anchor.position = Vector2(2,0)
	elif Model == 4:
		Screen_Anchor.position = Vector2(1,4)
