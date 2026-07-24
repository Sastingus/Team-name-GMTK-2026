extends Node2D

@onready var timer_label: Label = $Ui/TimerLabel
@onready var explosion: AnimatedSprite2D = $Ui/Explosion
@onready var lose_label: Label = $Ui/LoseLabel

func _process(delta: float) -> void:
	timer_label.text = str(round(Globals.game_timer*10)/10)

func _ready() -> void:
	SignalBus.lose.connect(lose)

func lose():
	explosion.visible = true
	lose_label.visible = true
	explosion.play("default")
