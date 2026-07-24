extends Node2D

@onready var timer_label: Label = $Ui/TimerLabel
@onready var explosion: AnimatedSprite2D = $Ui/LoseLabel/Explosion
@onready var lose_label: Label = $Ui/LoseLabel
@onready var win_label: Label = $Ui/WinLabel

func _process(delta: float) -> void:
	timer_label.text = str(round(Globals.game_timer*10)/10)

func _ready() -> void:
	SignalBus.lose.connect(lose)
	SignalBus.win.connect(win)

func win():
	win_label.visible = true

func lose():
	lose_label.visible = true
	explosion.play("default")


func _on_restart_button_pressed() -> void:
	Globals._ready()
	get_tree().change_scene_to_packed(preload("res://scenes/worlds/main_menu.tscn"))
