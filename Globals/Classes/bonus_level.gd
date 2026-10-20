class_name Bonus_Level extends SceneLevel

@export var start_timer:Timer
@export var level_time_amount:int = 30
@export var TimeLabel:Label
@onready var labelTimer:=Timer.new()
@onready var time_left:=level_time_amount
var real_crt_amount

func _ready() -> void:
	TimeLabel.text = str(level_time_amount)
	real_crt_amount = CRT_Amount
	CRT_Amount = 100
	start_timer.timeout.connect(on_timeout)
	labelTimer.timeout.connect(on_label_timer_timeout)
	TimeLabel.visible = false
	self.add_child(labelTimer)

func insert_player(Player:PlayerNode):
	
	start_timer.start(level_time_amount)
	TimeLabel.visible = true
	labelTimer.start(1)
	super(Player)

func on_timeout():
	if 100 - CRT_Amount == real_crt_amount:
		PlayerStatsManager.add_life()
	CRT_Amount = 0

func change_label():
	pass
	
func on_label_timer_timeout():
	labelTimer.start(1)
	time_left -= 1
	TimeLabel.text = str(time_left)
	if time_left <=0:
		TimeLabel.visible = false
	
	
func _process(delta: float) -> void:
	if 100 - CRT_Amount == real_crt_amount:
		start_timer.stop()
		labelTimer.stop()
		on_timeout()
	
