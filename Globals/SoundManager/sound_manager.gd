extends Node

@export var _bgmplayer:AudioStreamPlayer2D
var current_bgm_volume:float
var current_sfx_volume:float

func _bgmvolume(new_volume:float):
	current_bgm_volume = new_volume
	_bgmplayer.volume_db = new_volume

func _sfxvolume(new_volume:float):
	current_sfx_volume = new_volume

func play_bgm(sound:AudioStream):
	_bgmplayer.stream = sound
	_bgmplayer.play()
	
func play_sfx(sound:AudioStream):
	
	var _player := AudioStreamPlayer2D.new()
	self.add_child(_player)
	_player.volume_db = current_sfx_volume
	_player.stream = sound
	_player.play()
	await _player.finished
	_player.queue_free()
	
